class Api::V1::Members::ReleaseInfoController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    shop = Shop.find(params[:shop_id])
    @release_info = shop.release_info.published.order(created_at: :desc)
  end

  def show
    @release_info = ReleaseInfo.find_by(id: params[:id])
    render json: { message: '対象のお知らせが見つかりませんでした。' }, status: :not_found if @release_info.blank?
  end
end
