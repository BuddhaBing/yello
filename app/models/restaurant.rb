class Restaurant < ActiveRecord::Base
  attr_accessor :address

  has_many :reviews, dependent: :destroy
  has_attached_file :rest_image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '500x500>',
  }
  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude

  validates :user_id, presence: true
  validates :name, length: { minimum: 3 }, uniqueness: true
  validates_attachment_content_type :rest_image, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :rest_image, less_than: 3.megabytes

  phony_normalize :telephone, default_country_code: 'GB'
  validates :telephone, phony_plausible: true

  after_validation :geocode
  after_validation :reverse_geocode  # auto-fetch address

  def rating
    return 0 if reviews.count == 0
    (reviews.map { |review| review.rating }.reduce(0.0, :+) / reviews.count * 2).floor
  end
end
