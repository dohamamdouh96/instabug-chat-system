class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :token, unique: true
      t.integer :chats_count, default: 0, null: false

      t.timestamps
    end
    add_index :applications, :token, unique: true
  end
end