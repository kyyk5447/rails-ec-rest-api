class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :item
  validates :quantity, presence: true, numericality: { greater_than: 0 }
end
