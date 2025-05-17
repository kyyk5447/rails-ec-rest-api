class ShopCategoryAssignment < ApplicationRecord
  belongs_to :shop
  belongs_to :shop_category

  validates :shop_id, uniqueness: { scope: :shop_category_id }
end 