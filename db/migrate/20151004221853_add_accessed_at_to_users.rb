class AddAccessedAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :accessed_at, :datetime, after: :remember_created_at
  end
end
