class Photo < ActiveRecord::Base
  belongs_to :user
  belongs_to :section

  mount_uploader :image, PhotoUploader

  attr_accessible :name, :description, :image, :remote_image_url, :image_cache

  validates :name, presence: true, length: 2..60

  validates :remote_image_url, presence: true, format: {
    with:     %r{\.(gif|jpg|png)$}i,
    message:  'must be a URL for GIF, JPG, or PNG image.'
  }

  alias_attribute :title, :name
end
