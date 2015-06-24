class AddImageFileToPresentation < ActiveRecord::Migration
  def change
    add_column :presentations, :image_file, :string, after: :pdf_file
  end
end
