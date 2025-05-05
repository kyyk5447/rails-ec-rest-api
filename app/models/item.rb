class Item < ApplicationRecord
  mount_uploader :image, ItemImageUploader

  belongs_to :shop
  has_many :reviews, dependent: :destroy

  enum :status, {
    unpublished: 0,
    published: 1
  }

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: statuses.keys }
end
