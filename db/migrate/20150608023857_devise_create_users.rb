class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :name

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end
  end
end
