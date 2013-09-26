class EdmodoCreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title, null: false
      t.integer :member_count
      t.text :owner_ids
      t.string :subject
      t.string :sub_subject
      t.integer :start_level
      t.integer :end_level
      t.integer :edmodo_id, null: false

      t.timestamps
    end

    add_index :groups, :edmodo_id, unique: true
  end
end
