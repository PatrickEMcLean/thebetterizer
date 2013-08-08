class CreateWorkHistories < ActiveRecord::Migration
  def change
    create_table :work_histories do |t|
      t.integer :work_id
      t.string :status

      t.timestamps
    end
  end
end
