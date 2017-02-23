class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_attached_file :rest_image, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>',
    large: '500x500>',
  }

  validates :user_id, presence: true
  validates :name, length: { minimum: 3 }, uniqueness: true
  validates_attachment_content_type :rest_image, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :rest_image, less_than: 3.megabytes
end
