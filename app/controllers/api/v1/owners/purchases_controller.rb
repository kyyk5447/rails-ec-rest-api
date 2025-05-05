class Api::V1::Owners::PurchasesController < ApplicationController
  before_action :authenticate_owner!

  PER_PAGE = 10

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    shop = Shop.find(params[:shop_id])
    @purchases = Purchase.joins(purchase_items: :item)
                         .where(items: { shop_id: shop.id })
                         .includes(:member, purchase_items: :item)
                         .distinct
                         .order(created_at: :desc)
                         .page(page)
                         .per(PER_PAGE)
  end

  def show
    @purchase = Purchase.joins(purchase_items: :item)
                        .where(id: params[:id])
                        .includes(:member, purchase_items: :item)
                        .first

    render json: { message: '対象の購入履歴が見つかりませんでした' }, status: :not_found if @purchase.blank?
  end
end
