class CreateChatParticipations < ActiveRecord::Migration
  def change
    create_table :chat_participations do |t|
      t.references :chat, index: true, null: false
      t.references :user, index: true, null: false
      t.datetime :read_at
      t.datetime :archived_at

      t.timestamps
    end
  end
end
