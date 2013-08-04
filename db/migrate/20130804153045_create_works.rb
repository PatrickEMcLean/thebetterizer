class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.integer :user_id
      t.integer :coach_id
      t.string :student_audience
      t.string :student_desired_outcome
      t.string :student_comment
      t.string :student_essence
      t.string :student_feedback
      t.string :coach_what_you_did
      t.string :coach_how_feel
      t.string :coach_homework
      t.string :coach_well
      t.string :coach_not_so_well
      t.string :coach_comment
      t.string :document_url
      t.string :youtube_url
      t.boolean :approved

      t.timestamps
    end
  end
end
