class Api::V1::Members::ShippingInfoController < ApplicationController
  before_action :authenticate_member!

  def index
    @shipping_info = current_member.shipping_info.order(created_at: :desc)
  end

  def show
    @shipping_info = current_member.shipping_info.find_by(id: params[:id])
    return render json: { message: '発送情報が見つかりませんでした。' }, status: :not_found if @shipping_info.blank?
  end

  def create
    shipping_info = current_member.shipping_info.new(shipping_info_params)

    if shipping_info.save
      head :no_content
    else
      render json: { errors: shipping_info.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    shipping_info = current_member.shipping_info.find_by(id: params[:id])
    return render json: { message: '発送情報が見つかりませんでした。' }, status: :not_found if shipping_info.blank?

    if shipping_info.update(shipping_info_params)
      head :no_content
    else
      render json: { errors: shipping_info.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    shipping_info = current_member.shipping_info.find_by(id: params[:id])
    return render json: { message: '発送情報が見つかりませんでした。' }, status: :not_found if shipping_info.blank?

    if shipping_info.destroy
      head :no_content
    else
      render json: { errors: shipping_info.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def shipping_info_params
    params.require(:shipping_info).permit(:postal_code, :country, :prefecture, :city, :address)
  end
end
