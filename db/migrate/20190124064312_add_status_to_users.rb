class AddStatusToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :boolean, default: true
    remove_column :users, :is_deleted
  end
end
