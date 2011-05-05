class AddUsersRolesRightsTables < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.integer     :role_id
      t.integer     :user_id
    end

    create_table :rights_roles, :id => false do |t|
      t.integer     :right_id
      t.integer     :role_id
    end

  end

  def self.down
    drop_table :roles_users
    drop_table :rights_roles

  end
end
