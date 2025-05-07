class Company < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
end
