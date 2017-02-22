class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :user_id, presence: true

  validates :name, length: { minimum: 3 }, uniqueness: true
end
