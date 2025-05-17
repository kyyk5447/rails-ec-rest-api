class Shop < ApplicationRecord
  mount_uploader :image, ShopImageUploader

  belongs_to :owner
  has_many :shop_category_assignments, dependent: :destroy
  has_many :shop_categories, through: :shop_category_assignments
  has_many :items, dependent: :destroy
  has_many :release_info, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 300 }
  validate :must_have_at_least_one_category

  private

  def must_have_at_least_one_category
    errors.add(:base, :must_have_category) if shop_categories.empty?
  end
end
