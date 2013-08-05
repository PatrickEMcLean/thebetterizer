class AddDocumentSettingsToWork < ActiveRecord::Migration
  def change
    add_column :works, :google_file_id, :string
  end
end
