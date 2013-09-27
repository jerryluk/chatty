class AddEdmodoUserIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :edmodo_user_id, :integer
  end
end
