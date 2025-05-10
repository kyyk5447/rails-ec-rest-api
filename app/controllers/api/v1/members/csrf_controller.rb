class Api::V1::Members::CsrfController < ApplicationController
  before_action :authenticate_member!

  def index
    @csrf_token = new_csrf_token
  end
end
