class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.decimal :amount, precision: 16, scale: 2, null: false
      t.string :description
      t.integer :kind, default: 0
      t.integer :group_id
      t.integer :category_id, default: nil
      t.timestamps
    end
  end
end
