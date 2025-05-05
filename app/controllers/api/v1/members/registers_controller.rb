class Api::V1::Members::RegistersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    member = Member.new(register_params)

    begin
      member.save!
      sign_in(:member, member)
    rescue StandardError => e
      render json: { errors: member.errors.messages.values.flatten }, status: :unprocessable_entity
    end
  end

  def register_params
    params.require(:member).permit(:first_name, :first_name_kana, :last_name, :last_name_kana, :tel, :gender, :birthday, :email, :password, :password_confirmation)
  end
end