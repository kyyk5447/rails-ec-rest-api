# frozen_string_literal: true

class CamelCaseTransformer
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    log_debug "Request method: #{request.method}"
    log_debug "Content-Type: #{request.content_type}"

    if json_request?(request)
      transform_json_request(env, request)
    elsif multipart_request?(request)
      transform_multipart_request(env, request)
    end

    # レスポンスの処理
    status, headers, response = @app.call(env)

    return [status, headers, response] unless json_response?(headers)

    transformed_response = []
    
    response.each do |body|
      next transformed_response << body if body.empty?
      
      begin
        json_response = JSON.parse(body)
        log_debug "Original response: #{json_response}"
        camelized_response = to_camel_case(json_response)
        log_debug "Transformed response: #{camelized_response}"
        transformed_response << camelized_response.to_json
      rescue JSON::ParserError
        log_error "Failed to parse JSON response"
        transformed_response << body
      end
    end

    [status, headers, transformed_response]
  end

  private

  def json_request?(request)
    request.content_type =~ /json/
  end

  def multipart_request?(request)
    request.content_type =~ /multipart\/form-data/
  end

  def json_response?(headers)
    headers['Content-Type']&.include?('application/json')
  end

  def transform_json_request(env, request)
    log_debug "Processing JSON request"
    request.body.rewind
    body = request.body.read
    return if body.empty?

    begin
      params = JSON.parse(body)
      log_debug "Original JSON params: #{params}"
      
      # キャメルケースからスネークケースに変換
      transformed_params = deep_transform_keys_to_snake(params)
      
      log_debug "Transformed JSON params: #{transformed_params}"
      
      # 変換したJSONをセット
      env['RAW_POST_DATA'] = transformed_params.to_json
      env['action_dispatch.request.request_parameters'] = transformed_params
      
      # リクエストの変換結果を詳細にログ
      log_debug "Final params after transformation: #{transformed_params.inspect}"
    rescue JSON::ParserError => e
      log_error "Failed to parse JSON request: #{e.message}"
    end
    request.body.rewind
  end

  def transform_multipart_request(env, request)
    log_debug "Processing multipart form data"
    
    begin
      # パラメータの変換
      params = transform_nested_params(request.params)
      log_debug "Transformed multipart params: #{params.inspect}"
      
      # 変換したパラメータを環境変数に設定
      update_env_params(env, params)
      
      log_debug "Final params set to environment"
    rescue => e
      log_error "Failed to transform multipart request: #{e.message}"
      log_error e.backtrace.join("\n")
    end
  end

  # ネストされたパラメータを変換（form-data用）
  def transform_nested_params(params)
    result = {}
    
    params.each do |key, value|
      if value.is_a?(ActionController::Parameters) || value.is_a?(Hash)
        # ネストされたハッシュを処理
        transformed_nested = transform_nested_params(value)
        result[transform_key(key)] = transformed_nested
      elsif value.is_a?(Array)
        # 配列の各要素を処理
        result[transform_key(key)] = value.map do |item|
          if item.is_a?(Hash) || item.is_a?(ActionController::Parameters)
            transform_nested_params(item)
          else
            item
          end
        end
      else
        # 単純な値（文字列、数値、ファイルなど）
        result[transform_key(key)] = value
      end
    end
    
    result
  end
  
  # 環境変数のパラメータを更新
  def update_env_params(env, params)
    # Rack用のパラメータ更新
    if env['rack.request.form_hash']
      env['rack.request.form_hash'] = params
    end
    
    # ActionDispatch用のパラメータ更新
    if env['action_dispatch.request.request_parameters']
      env['action_dispatch.request.request_parameters'] = params
    end
  end
  
  # キーを変換（キャメルケース→スネークケース）
  def transform_key(key)
    key.to_s.underscore
  end

  # 深いネストでもキーをキャメルケースからスネークケースに変換
  def deep_transform_keys_to_snake(object)
    case object
    when Hash
      object.each_with_object({}) do |(key, value), result|
        result[transform_key(key)] = deep_transform_keys_to_snake(value)
      end
    when Array
      object.map { |item| deep_transform_keys_to_snake(item) }
    when ActionDispatch::Http::UploadedFile
      # ファイルは変換せずそのまま
      object
    else
      object
    end
  end

  # 深いネストでもキーをスネークケースからキャメルケースに変換（レスポンス用）
  def to_camel_case(object)
    case object
    when Hash
      object.each_with_object({}) do |(key, value), result|
        camel_key = key.to_s.camelize(:lower)
        result[camel_key] = to_camel_case(value)
      end
    when Array
      object.map { |item| to_camel_case(item) }
    else
      object
    end
  end
  
  # デバッグログを出力
  def log_debug(message)
    Rails.logger.debug "[CamelCaseTransformer] #{message}"
  end
  
  # エラーログを出力
  def log_error(message)
    Rails.logger.error "[CamelCaseTransformer] #{message}"
  end
end 