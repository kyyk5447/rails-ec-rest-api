class Api::V1::Members::ShopsController < ApplicationController
  PER_PAGE = 10

  def index
    page = params[:page].to_i.positive? ? params[:page].to_i : 1
    @shops = Shop.page(page).per(PER_PAGE)
  end

  def show
    @shop = Shop.includes(:items).find_by(id: params[:id])
    render json: { message: 'ショップが見つかりませんでした。' }, status: :not_found if @shop.blank?
  end
end
