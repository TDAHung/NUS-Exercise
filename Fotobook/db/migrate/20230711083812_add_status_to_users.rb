class AddStatusToUsers < ActiveRecord::Migration[7.0]
  def up
    add_column :users, :status, :integer, default: 1
    User.update_all(status: 1)
    change_column :users, :status, :integer, null: false
  end

  def down
    remove_column :users, :status
  end
end
