class RemoveTokensFromUserAccounts < ActiveRecord::Migration
  def change
    remove_column :user_accounts, :token_expires_at, :datetime, after: :token_secret
    remove_column :user_accounts, :token_secret, :string, after: :token
    remove_column :user_accounts, :token, :string, null: false, after: :image_url
  end
end
