class CreatePresentations < ActiveRecord::Migration
  def change
    create_table :presentations do |t|
      t.integer :user_id,      null: false
      t.boolean :is_public,    null: false, default: false
      t.string :original_file
      t.string :pdf_file

      t.timestamps null: false
    end
    add_index :presentations, [:user_id, :is_public]
  end
end
