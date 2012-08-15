class Photo < ActiveRecord::Base
  belongs_to :user

  mount_uploader :image, PhotoUploader

  attr_accessible :name, :description, :image, :remote_image_url, :image_cache

  validates :name, presence: true, length: 2..60

  alias_attribute :title, :name
end
