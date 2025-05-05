class Api::V1::Owners::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    self.resource = warden.authenticate(auth_options)
    if resource
      sign_in(resource_name, resource)
      render json: { message: 'ログインに成功しました。' }
    else
      render json: { errors: ['メールアドレスまたはパスワードが違います。'] }, status: :unprocessable_entity
    end
  end

  def destroy
    if owner_signed_in?
      sign_out(resource_name)
      render json: { message: 'ログアウトに成功しました。' }, status: :ok
    else
      render json: { message: '既にログアウトは完了しています。' }, status: :ok
    end
  end

  private

  def sign_in_failed
    render json: { message: 'ログインに失敗しました。' }
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#sign_in_failed" }
  end

  def respond_to_on_destroy
  end
end