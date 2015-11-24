class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.integer  :user_id,      null: false
      t.string   :provider,     null: false
      t.string   :uid,          null: false
      t.string   :token,        null: false, limit: 511
      t.string   :token_secret
      t.datetime :token_expires_at

      t.timestamps null: false
    end
    add_index :user_accounts, [:user_id, :provider], unique: true
    add_index :user_accounts, [:provider, :uid],     unique: true
  end
end
