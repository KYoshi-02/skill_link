class User < ApplicationRecord
  belongs_to :company
  has_many :knowhows
  has_many :answers

  enum role: { general: 0, admin: 1 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 30 }
  validates :nick_name, presence: true, length: { maximum: 20 }

  VALID_PASSWORD_REGEX = /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,20}\z/
  validates :password, format: {
    with: VALID_PASSWORD_REGEX,
    message: 'は半角英数字6文字以上20文字以内で入力してください'
  }, if: :password_required?
end
