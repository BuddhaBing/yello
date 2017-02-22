class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :user_id, presence: true

  validates :name, length: { minimum: 3 }, uniqueness: true

  def rating
    sum = 0
    self.reviews.each do |review|
      sum += review.rating
    end
    sum/self.reviews.count
  end
end
