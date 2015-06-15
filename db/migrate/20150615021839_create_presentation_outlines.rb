class CreatePresentationOutlines < ActiveRecord::Migration
  def change
    create_table :presentation_outlines do |t|
      t.integer :presentation_id, null: false
      t.text    :body,                         limit: 16.megabyte - 1 # mediumtext

      t.timestamps null: false
    end
    add_index :presentation_outlines, :presentation_id, unique: true
  end
end
