class Api::V1::Members::ItemsController < ApplicationController
  PER_PAGE = 10

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @items = Item.published.order(created_at: :desc).page(page).per(PER_PAGE)
  end

  def show
    @item = Item.includes(:reviews).find_by(id: params[:id])
    render json: { message: '商品が見つかりませんでした。' }, status: :not_found if @item.blank?
  end
end
