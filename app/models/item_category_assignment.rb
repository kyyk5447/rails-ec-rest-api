class ItemCategoryAssignment < ApplicationRecord
  belongs_to :item
  belongs_to :item_category

  validates :item_id, uniqueness: { scope: :item_category_id }
end
