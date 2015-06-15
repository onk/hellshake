# == Schema Information
#
# Table name: presentations
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  is_public     :boolean          default(FALSE), not null
#  original_file :string(255)
#  pdf_file      :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  user_id_and_is_public  (user_id,is_public)
#

class Presentation < ActiveRecord::Base
  mount_uploader :original_file, PdfUploader
  mount_uploader :pdf_file, PdfUploader

  belongs_to :user
  has_one :presentation_outline

  def png_url
    pdf_file.url.sub(/pdf$/, "png")
  end
end
