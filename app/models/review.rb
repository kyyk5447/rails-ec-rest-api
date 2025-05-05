class Review < ApplicationRecord
  validates :title, presence: true, length: { maximum: 30 }
  validates :comment, presence: true, length: { maximum: 300 }

  belongs_to :member
  belongs_to :item
end
