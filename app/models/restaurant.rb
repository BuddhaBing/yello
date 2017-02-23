class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates :user_id, presence: true

  validates :name, length: { minimum: 3 }, uniqueness: true

  def rating
    return 0 if reviews.count == 0
    (reviews.map { |review| review.rating }.reduce(0.0, :+) / reviews.count * 2).floor
  end
end
