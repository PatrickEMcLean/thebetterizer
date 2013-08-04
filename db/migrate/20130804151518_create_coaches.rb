class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :full_name
      t.string :bio
      t.string :picture_url
      t.float :work_percentage
      t.integer :user_id

      t.timestamps
    end
  end
end
