class AddColumnToProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :is_deleted
    add_column :profiles, :birthday, :datetime
    add_column :profiles, :description, :text
  end
end
