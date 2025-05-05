class Api::V1::Owners::ReleaseInfoController < ApplicationController
  before_action :authenticate_owner!
  before_action :set_release_info, only: [:show, :update, :destroy]

  PER_PAGE = 10

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @release_info = current_owner_release_info.order(created_at: :desc).page(page).per(PER_PAGE)
  end

  def show
  end

  def create
    shop = current_owner.shops.find_by(id: release_info_params[:shop_id])
    return render json: { message: 'ショップが見つかりませんでした。' }, status: :not_found if shop.blank?
    release_info = shop.release_info.build(release_info_params)
    if release_info.save
      head :no_content
    else
      render json: { errors: release_info.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @release_info.update(release_info_params)
      head :no_content
    else
      render json: { errors: release_info.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @release_info.destroy
      head :no_content
    else
      render json: { errors: @release_info.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_release_info
    @release_info = current_owner_release_info.find_by(id: params[:id])
    render json: { message: '対象のお知らせが見つかりませんでした。' }, status: :not_found if @release_info.blank?
  end

  def current_owner_release_info
    ReleaseInfo.joins(:shop).where(shops: { owner_id: current_owner.id })
  end

  def release_info_params
    params.require(:release_info).permit(:shop_id, :title, :body, :status)
  end
end
