class WorkHistory < ActiveRecord::Base
  attr_accessible :status, :work_id

  belongs_to :work
end
