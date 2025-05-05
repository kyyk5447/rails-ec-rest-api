class Owner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shops, dependent: :destroy

  KATAKANA_REGEX = /\A[\p{katakana}\u{30fc}]+\z/

  validates :first_name, presence: true, length: { maximum: 20 }
  validates :last_name,  presence: true, length: { maximum: 20 }

  validates :first_name_kana, 
            presence: true,
            length: { maximum: 20 },
            format: { with: KATAKANA_REGEX, message: 'カタカナで入力してください' },
            allow_blank: true

  validates :last_name_kana,
            presence: true,
            length: { maximum: 20 },
            format: { with: KATAKANA_REGEX, message: 'カタカナで入力してください' },
            allow_blank: true
end