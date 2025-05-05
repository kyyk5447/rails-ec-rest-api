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
    unless owner_signed_in?
      render_unauthorized
    end
  end

  def authenticate_member!
    unless member_signed_in?
      render_unauthorized
    end
  end
end
