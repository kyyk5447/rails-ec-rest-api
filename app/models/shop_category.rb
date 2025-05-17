class ShopCategory < ApplicationRecord
  # カテゴリの定数定義
  MENS_FASHION = 1
  WOMENS_FASHION = 2
  KIDS_FASHION = 3
  SHOES = 4
  BAGS = 5
  ACCESSORIES = 6
  SPORTS = 7
  OUTDOOR = 8
  BEAUTY = 9
  HEALTH = 10
  FOOD = 11
  INTERIOR = 12

  # カテゴリの名称定義
  NAMES = {
    MENS_FASHION => 'メンズファッション',
    WOMENS_FASHION => 'レディースファッション',
    KIDS_FASHION => 'キッズファッション',
    SHOES => 'シューズ',
    BAGS => 'バッグ',
    ACCESSORIES => 'アクセサリー',
    SPORTS => 'スポーツ',
    OUTDOOR => 'アウトドア',
    BEAUTY => 'コスメ・美容',
    HEALTH => 'ヘルス・ボディケア',
    FOOD => 'フード・グルメ',
    INTERIOR => 'インテリア・雑貨'
  }.freeze

  has_many :shop_category_assignments, dependent: :destroy
  has_many :shops, through: :shop_category_assignments

  validates :id, presence: true, uniqueness: true, inclusion: { in: NAMES.keys }
  validates :name, presence: true

  def self.all_categories
    NAMES.map do |id, name|
      find_or_initialize_by(id: id, name: name)
    end
  end

  def self.find_by_id(id)
    return nil unless NAMES.key?(id)
    find_or_initialize_by(id: id, name: NAMES[id])
  end
end 