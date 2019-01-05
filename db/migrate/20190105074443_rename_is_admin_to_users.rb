class RenameIsAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :is_admin, :integer
    rename_column :users, :is_admin, :role
  end
end
