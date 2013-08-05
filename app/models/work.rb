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
    :temp_document

  belongs_to :user
  belongs_to :coach


end
