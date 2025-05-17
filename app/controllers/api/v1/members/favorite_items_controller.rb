class Api::V1::Members::FavoriteItemsController < ApplicationController
  before_action :authenticate_member!

  PER_PAGE = 10

  def index
    @favorite_items = current_member.favorites.page(params[:page]).per(PER_PAGE)
  end

  def update
    item = Item.find_by(id: params[:id])
    return render json: { message: '対象の商品が見つかりませんでした。' }, status: :not_found if item.blank?

    favorite_item = current_member.favorite_items.find_or_initialize_by(item: item)

    if favorite_item.persisted?
      favorite_item.destroy
      head :no_content
    else
      favorite_item.save
      head :no_content
    end
  end
end
