class CreateUsersRoles < ActiveRecord::Migration
  def up
    create_table :roles_users do |t|
      t.belongs_to :user
      t.belongs_to :role
    end
  end

  def down
    drop_table :roles_users
  end
end
