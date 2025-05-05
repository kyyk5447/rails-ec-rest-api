class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shipping_info, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorite_items, dependent: :destroy
  has_many :favorites, through: :favorite_items, source: :item

  KATAKANA_REGEX = /\A[\p{katakana}\u{30fc}]+\z/

  enum :gender, {
    not_specified: 0,
    male: 1,
    female: 2
  }

  validates :first_name, :last_name, presence: true, length: { maximum: 20 }
  validates :first_name_kana,
            presence: true,
            length: { maximum: 20 },
            format: { with: KATAKANA_REGEX, message: 'カタカナで入力してください。' },
            allow_blank: true

  validates :last_name_kana,
            presence: true,
            length: { maximum: 20 },
            format: { with: KATAKANA_REGEX, message: 'カタカナで入力してください。' },
            allow_blank: true

  validates :tel, presence: true, length: { maximum: 15 }
  validates :gender, inclusion: { in: genders.keys, message: '性別は選択してください。' }
  validates :birthday, presence: true
end
