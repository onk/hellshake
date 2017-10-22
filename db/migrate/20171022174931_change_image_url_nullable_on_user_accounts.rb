class ChangeImageUrlNullableOnUserAccounts < ActiveRecord::Migration
  def change
    change_column_null :user_accounts, :image_url, true
  end
end
