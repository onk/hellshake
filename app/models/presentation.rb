# == Schema Information
#
# Table name: presentations
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string(255)      not null
#  is_public     :boolean          default(FALSE), not null
#  original_file :string(255)
#  pdf_file      :string(255)
#  image_file    :string(255)
#  published_at  :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  user_id_and_is_public  (user_id,is_public)
#

class Presentation < ActiveRecord::Base
  acts_as_taggable

  mount_uploader :original_file, PdfUploader
  mount_uploader :pdf_file, PdfUploader
  mount_uploader :image_file, ImageUploader

  belongs_to :user
  has_one :presentation_outline, dependent: :destroy

  scope :is_public, -> { where(is_public: true) }

  validates :title,        presence: true
  validates :published_at, presence: true

  def owner?(user)
    user_id == user.try!(:id)
  end
end
