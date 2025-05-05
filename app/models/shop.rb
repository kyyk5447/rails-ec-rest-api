class Shop < ApplicationRecord
  mount_uploader :image, ShopImageUploader

  belongs_to :owner
  has_many :items, dependent: :destroy
  has_many :release_info, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
end
