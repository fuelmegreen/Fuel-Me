class Page < ActiveRecord::Base
  has_many :sections, dependent: :destroy
  attr_accessible :namespace, :title, :header, :path
  validates :namespace, :title, :header, :path, presence: true
end
