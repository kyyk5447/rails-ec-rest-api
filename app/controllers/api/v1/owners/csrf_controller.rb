class Api::V1::Owners::CsrfController < ApplicationController
  before_action :authenticate_owner!

  def index
    render json: { csrf_token: new_csrf_token }
  end
end
