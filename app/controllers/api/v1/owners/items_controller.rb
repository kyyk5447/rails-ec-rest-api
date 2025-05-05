class Api::V1::Owners::ItemsController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_item, only: [:show, :update, :destroy]

  PER_PAGE = 10

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @items = current_owner_items.page(page).per(PER_PAGE)
  end

  def show
  end

  def create
    shop = current_owner.shops.find_by(id: item_params[:shop_id])
    return render json: { message: 'ショップが見つかりませんでした。' }, status: :not_found if shop.blank?
    item = shop.items.build(item_params)
    if item.save
      head :no_content
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      head :no_content
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @item.destroy
      head :no_content
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = current_owner_items.find_by(id: params[:id])
    render json: { message: '商品が見つかりませんでした。' }, status: :not_found if @item.blank?
  end

  def current_owner_items
    Item.joins(:shop).where(shops: { owner_id: current_owner.id })
  end

  def item_params
    permitted = params.require(:item).permit(:shop_id, :image, :name, :price, :description, :stock, :status)
    permitted[:price] = permitted[:price].to_i if permitted[:price].present?
    permitted[:stock] = permitted[:stock].to_i if permitted[:stock].present?
    permitted[:status] = permitted[:status].to_i if permitted[:status].present?
  
    permitted
  end
end