class Api::V1::Owners::ShopsController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_shop, only: [:show, :update, :destroy]

  PER_PAGE = 10

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @shops = current_owner.shops.page(page).per(PER_PAGE)
  end

  def show
  end

  def create
    shop = current_owner.shops.new(shop_params)
    if shop.save
      head :no_content
    else
      render json: { errors: shop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @shop.update(shop_params)
      head :no_content
    else
      render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @shop.destroy
      head :no_content
    else
      render json: { errors: @shop.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_shop
    @shop = current_owner.shops.find_by(id: params[:id])
    render json: { message: '対象のショップが見つかりませんでした。' }, status: :not_found if @shop.blank?
  end

  def shop_params
    params.require(:shop).permit(:image, :name, :description)
  end
end