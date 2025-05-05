class Api::V1::Members::PurchasesController < ApplicationController
  before_action :authenticate_member!

  PER_PAGE = 10

  def index
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    @purchases = current_member.purchases.includes(purchase_items: :item).order(created_at: :desc).page(page).per(PER_PAGE)
  end

  def create
    cart = current_member.cart
    return render json: { message: '商品をカートに追加してください。' }, status: :not_found if cart.blank?

    cart_items = cart.cart_items.includes(:item)
    return render json: { error: 'カートが空です。' }, status: :unprocessable_entity if cart_items.empty?

    cart_items.each do |cart_item|
      if cart_item.item.stock < cart_item.quantity
        return render json: { error: "#{cart_item.item.name}の在庫が不足しています。" }, status: :unprocessable_entity
      end
    end

    total_price = 0

    begin
      ActiveRecord::Base.transaction do
        purchase = current_member.purchases.create!(total_price: 0)

        cart_items.each do |cart_item|
          item = cart_item.item
          quantity = cart_item.quantity
          subtotal = item.price * quantity

          item.update!(stock: cart_item.item.stock - quantity)

          purchase.purchase_items.create!(
            item: item,
            quantity: quantity,
            subtotal: subtotal
          )
          total_price += subtotal
        end

        purchase.update!(total_price: total_price)
        current_member.cart.destroy

        return render json: { message: '購入が完了しました。' }, status: :created
      end
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def destroy
    purchase = current_member.purchases.find_by(id: params[:id])
    return render json: { message: '購入履歴が存在しません。' }, status: :not_found if purchase.blank?

    if purchase.destroy
      head :no_content
    else
      render json: { errors: purchase.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
