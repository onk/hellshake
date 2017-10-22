class AddRawInfoToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :raw_info, :text, after: :image_url
  end
end
