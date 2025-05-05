class Api::V1::Owners::MembersController < ApplicationController
  before_action :authenticate_owner!

  def identity
    @owner = current_owner
  end

  def update
    if current_owner.update(profile_update_params)
      bypass_sign_in(current_owner)
      head :no_content
    else
      render json: { errors: current_owner.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def profile_update_params
    params.require(:owner).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :email, :password, :password_confirmation)
  end
end
