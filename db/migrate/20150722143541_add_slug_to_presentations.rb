class AddSlugToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :slug, :string, null: false, after: :title
    add_index :presentations, [:user_id, :slug], unique: true
  end
end
