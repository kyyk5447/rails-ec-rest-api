class Api::V1::Owners::RegistersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    owner = Owner.new(register_params)

    begin
      owner.save!
      sign_in(:owner, owner)
    rescue StandardError => e
      render json: { errors: owner.errors.messages.values.flatten }, status: :unprocessable_entity
    end
  end

  private

  def register_params
    params.require(:owner).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :email, :password, :password_confirmation)
  end
end
