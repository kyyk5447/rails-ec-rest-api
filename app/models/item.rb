class Item < ApplicationRecord
  mount_uploader :image, ItemImageUploader

  belongs_to :shop
  has_many :cart_items, dependent: :destroy
  has_many :purchase_items, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :item_category_assignments, dependent: :destroy
  has_many :item_categories, through: :item_category_assignments

  enum :status, {
    unpublished: 0,
    published: 1
  }

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }
  validates :status, inclusion: { in: statuses.keys }
  validates :shop_id, presence: true
  validate :must_have_at_least_one_category

  private

  def must_have_at_least_one_category
    errors.add(:base, :must_have_category) if item_categories.empty?
  end
end
