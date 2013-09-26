class EdmodoCreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.references :user, null: false, index: true
      t.references :group, null: false, index: true
      t.boolean :is_owner, default: false

      t.timestamps
    end
  end
end
