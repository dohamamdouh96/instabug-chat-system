class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number, unique:true, default: 1, null: false
      t.integer :messages_count, default: 0, null: false
      t.references :application, foreign_key: true

      t.timestamps
    end
  end
end
