class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number, unique:true, default: 1, null: false
      t.text :body, null: false
      t.references :chat, foreign_key: true

      t.timestamps
    end
  end
end
