class AddUsernameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string, null: false, after: :name
    add_index :users, :username, unique: :true
  end
end
