class AddPublishedAtToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :published_at, :datetime, null: false, after: :image_file
  end
end
