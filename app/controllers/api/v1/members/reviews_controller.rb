class Api::V1::Members::ReviewsController < ApplicationController

  PER_PAGE = 10

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    @reviews = current_member.reviews.page(page).per(PER_PAGE)
  end

  def create
    item = Item.find_by(id: review_params[:item_id])
    render json: { message: '対象の商品が見つかりませんでした。' }, status: :not_found if item.blank?

    review = current_member.reviews.new(review_params.merge(item: item))

    if review.save
      head :no_content
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    review = current_member.reviews.find_by(id: params[:id])
    return render json: { message: 'レビューが存在しません。' }, status: :not_found if review.blank?

    if review.destroy
      head :no_content
    else
      render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:item_id, :title, :comment, :rating)
  end
end
