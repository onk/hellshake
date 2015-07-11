class AddImageUrlToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :image_url, :string, null: false, after: :uid
  end
end
