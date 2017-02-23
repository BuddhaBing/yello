class Review < ActiveRecord::Base
  validates :rating, inclusion: (1..5)
  validates_uniqueness_of :user_id, :scope => :restaurant_id

end
