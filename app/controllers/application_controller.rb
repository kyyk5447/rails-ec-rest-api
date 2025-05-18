class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :exception
  before_action :transform_params_to_snake_case

  protected

  def new_csrf_token
    form_authenticity_token
  end

  def render_unauthorized
    render json: { message: 'ログインもしくはアカウント登録してください' }, status: :unauthorized
  end

  def authenticate_owner!
    return if owner_signed_in?

    render_unauthorized
  end

  def authenticate_member!
    return if member_signed_in?

    render_unauthorized
  end

  private

  def transform_params_to_snake_case
    params.keys.each do |key|
      next unless key.match?(/[A-Z]/)
      snake_key = camelize_to_snake(key)
      
      # キャメルケースの値を取得し、スネークケースに変換
      camel_value = params.delete(key)
      if camel_value.is_a?(ActionController::Parameters) || camel_value.is_a?(Hash)
        snake_value = deep_transform_keys_to_snake(camel_value.to_unsafe_h)
      else
        snake_value = camel_value
      end

      # スネークケースのキーに値をセット
      params[snake_key] = snake_value
    end

    # ネストされたパラメータも変換
    params.each do |key, value|
      if value.is_a?(ActionController::Parameters) || value.is_a?(Hash)
        params[key] = deep_transform_keys_to_snake(value.to_unsafe_h)
      end
    end
  end

  def deep_transform_keys_to_snake(hash)
    hash.each_with_object({}) do |(key, value), result|
      snake_key = camelize_to_snake(key)
      result[snake_key] = case value
        when Hash
          deep_transform_keys_to_snake(value)
        when Array
          value.map { |v| v.is_a?(Hash) ? deep_transform_keys_to_snake(v) : v }
        else
          value
        end
    end
  end

  def camelize_to_snake(key)
    key.to_s
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .downcase
  end
end
