class Work < ActiveRecord::Base
  attr_accessor :temp_text, :temp_document
  attr_accessible :user_id,
    :coach_id,
    :student_audience,
    :student_desired_outcome,
    :student_comment,
    :student_essence,
    :student_feedback,
    :coach_what_you_did,
    :coach_how_feel,
    :coach_homework,
    :coach_well,
    :coach_not_so_well,
    :coach_comment,
    :document_url,
    :google_file_id,
    :youtube_url,
    :approved,
    :temp_text,
    :temp_document,
    :work_histories,
    :work_histories_attributes

  belongs_to :user
  belongs_to :coach
  has_many :work_histories, inverse_of: :work, dependent: :destroy

  accepts_nested_attributes_for :work_histories

  def self.for_user(user)
    where(user_id: user.id)
  end

  def self.for_coach(user)
    where(coach_id: user.id)
  end

  def self.for_admin
    includes(:work_histories, :user).all
  end

  def current_status
    WorkHistory.where(work_id: id).order(:created_at).last
  end

  def status=(value)
    work_histories << WorkHistory.new(status: value.to_sym)
  end


end
