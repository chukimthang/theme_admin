class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :user_id
      t.datetime :deleted_at
      t.timestamps
    end

    add_index :groups, :user_id
    add_index :groups, :deleted_at
  end
end
