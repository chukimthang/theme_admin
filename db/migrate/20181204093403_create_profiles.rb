class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :full_name
      t.attachment :avatar
      t.boolean :gender, default: false
      t.boolean :is_deleted, default: false
      t.integer :user_id

      t.timestamps
    end
  end
end
