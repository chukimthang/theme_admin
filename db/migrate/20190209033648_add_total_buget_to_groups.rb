class AddTotalBugetToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :total_buget, :decimal, precision: 16, scale: 2, default: 0
  end
end
