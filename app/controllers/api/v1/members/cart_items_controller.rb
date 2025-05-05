class Api::V1::Members::CartItemsController < ApplicationController
  before_action :authenticate_member!

  def index
    cart = current_member.cart
    return render json: { message: 'カートが見つかりません。商品をカートに追加してください。' }, status: :not_found if cart.blank?
    @cart_items = cart.cart_items.includes(:item)
  end

  def create
    item = Item.find_by(id: cart_item_params[:item_id])
    return render json: { message: '商品が見つかりませんでした。' }, status: :not_found if item.blank?
    cart = current_member.cart || current_member.create_cart
    cart_item = cart.cart_items.find_or_initialize_by(item_id: item.id)
    new_quantity = cart_item.quantity.to_i + cart_item_params[:quantity].to_i

    if new_quantity > item.stock
      return render json: { message: '在庫が不足しています。' }, status: :unprocessable_entity
    end

    cart_item.quantity = new_quantity

    if cart_item.save
      head :no_content
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    cart = current_member.cart
    return render json: { message: 'カートが見つかりません。商品をカートに追加してください。' }, status: :not_found if cart.blank?
    cart_item = cart.cart_items.find_by(item_id: params[:id])
    return render json: { message: '指定された商品はカートに存在しません。' }, status: :not_found if cart_item.blank?

    if cart_item.destroy
      head :no_content
    else
      render json: { errors: cart_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def cart_item_params
    params.require(:cart).permit(:item_id, :quantity)
  end
end
