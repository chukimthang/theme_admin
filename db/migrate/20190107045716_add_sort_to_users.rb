class AddSortToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sort, :integer, default: 0
  end
end
