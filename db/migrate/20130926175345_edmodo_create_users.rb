class EdmodoCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_type, null: false
      t.string :edmodo_id, null: false
      t.string :first_name
      t.string :last_name
      t.string :title
      t.string :avatar_url
      t.string :thumb_url
      t.string :locale
      t.string :time_zone
      t.integer :school_id
      t.integer :district_id
      t.timestamps
    end

    add_index :users, :edmodo_id, unique: true
    add_index :users, :user_type
  end
end
