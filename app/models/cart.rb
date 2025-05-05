class Cart < ApplicationRecord
  belongs_to :member
  has_many :cart_items, dependent: :destroy
end
