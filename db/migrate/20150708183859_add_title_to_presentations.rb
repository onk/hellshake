class AddTitleToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :title, :string, null: false, after: :user_id
  end
end
