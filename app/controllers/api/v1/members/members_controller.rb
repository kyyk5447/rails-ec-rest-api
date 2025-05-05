class Api::V1::Members::MembersController < ApplicationController
  before_action :authenticate_member!

  def identity
    @member = current_member
  end

  def update
    if current_member.update(profile_update_params)
      bypass_sign_in(current_member)
      head :no_content
    else
      render json: { errors: current_member.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def profile_update_params
    params.require(:member).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :tel, :gender,
                                   :birthday, :email, :password, :password_confirmation)
  end
end
