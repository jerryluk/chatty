class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :subject
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
