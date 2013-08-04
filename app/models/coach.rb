class Coach < ActiveRecord::Base
  attr_accessible :bio, :full_name, :picture_url, :user_id, :work_percentage

  has_many :users, :through => :work
  has_many :works
end
