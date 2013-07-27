class Role < ActiveRecord::Base
  attr_accessible :key, :label

  has_and_belongs_to_many :users
end
