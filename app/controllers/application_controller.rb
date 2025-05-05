class ApplicationController < ActionController::API
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :exception

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
end
