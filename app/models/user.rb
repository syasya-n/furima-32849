class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  alphanumeric = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i
  full_width_char = /\A[ぁ-んァ-ン一-龥々]+\z/
  full_width_kana = /\A[ァ-ヶー－]+\z/

  validates :password, format: { with: alphanumeric, message: 'Include both letters and numbers' }

  with_options presence: true do
    validates :nickname
    validates :birth_date
    with_options format: { with: full_width_char, message: 'Full-width characters' } do
      validates :last_name_kanji
      validates :first_name_kanji
    end

    with_options format: { with: full_width_kana, message: 'Full-width katakana characters' } do
      validates :last_name_kana
      validates :first_name_kana
    end
  end
end
