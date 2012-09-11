class Section < ActiveRecord::Base
  attr_accessible :id, :content
  belongs_to :page
end
