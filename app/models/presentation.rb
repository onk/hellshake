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

  belongs_to :user
end
