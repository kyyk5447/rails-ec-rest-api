class ItemCategory < ApplicationRecord
  # 商品カテゴリーの定数
  TOPS = 1
  BOTTOMS = 2
  OUTERWEAR = 3
  DRESSES = 4
  SUITS = 5
  BAGS = 6
  SHOES = 7
  ACCESSORIES = 8
  HATS = 9
  GOODS = 10

  has_many :item_category_assignments, dependent: :destroy
  has_many :items, through: :item_category_assignments

  validates :name, presence: true

  def self.all_categories
    [
      { id: TOPS, name: "トップス" },
      { id: BOTTOMS, name: "ボトムス" },
      { id: OUTERWEAR, name: "アウター" },
      { id: DRESSES, name: "ワンピース" },
      { id: SUITS, name: "スーツ・フォーマル" },
      { id: BAGS, name: "バッグ" },
      { id: SHOES, name: "シューズ" },
      { id: ACCESSORIES, name: "アクセサリー" },
      { id: HATS, name: "帽子" },
      { id: GOODS, name: "小物" }
    ].map { |category| new(id: category[:id], name: category[:name]) }
  end
end
