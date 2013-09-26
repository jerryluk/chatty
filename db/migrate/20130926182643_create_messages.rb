class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :chat, index: true, null: false
      t.references :user, index: true, null: false
      t.text :content

      t.timestamps
    end
  end
end
