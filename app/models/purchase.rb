class Purchase < ApplicationRecord
  belongs_to :member
  has_many :purchase_items, dependent: :destroy
end
