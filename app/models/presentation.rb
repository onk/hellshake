# == Schema Information
#
# Table name: presentations
#
#  id            :integer          not null, primary key
#  user_id       :integer          not null
#  title         :string(255)      not null
#  slug          :string(255)      not null
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
#  user_id_and_slug       (user_id,slug) UNIQUE
#

class Presentation < ActiveRecord::Base
  include Presentation::SearchModule

  acts_as_taggable

  mount_uploader :original_file, PdfUploader
  mount_uploader :pdf_file, PdfUploader
  mount_uploader :image_file, ImageUploader

  # redis-objects override AR lock method
  class << self
    alias_method :ar_lock, :lock
  end
  include Redis::Objects
  class << self
    alias_method :redis_lock, :lock
    alias_method :lock, :ar_lock
    remove_method :ar_lock
  end
  include RedisObjectsDestroyable
  counter :access_count

  belongs_to :user
  has_one :presentation_outline, dependent: :destroy

  scope :is_public, -> { where(is_public: true) }
  scope :published_at_desc, -> { order(published_at: :desc) }

  VALID_SLUG_REGEX = /\A[0-9A-Za-z\-_]+\z/ # 英数と - _ の 2 つの半角記号
  validates :title,        presence: true
  validates :slug,         presence: true, format: { with: VALID_SLUG_REGEX, message: "英数と-_ のみで入力してください" }
  validates :published_at, presence: true

  def owner?(user)
    user_id == user.try!(:id)
  end

  def reupload(file)
    self.original_file.remove!
    self.pdf_file.remove!
    self.image_file.remove!
    self.presentation_outline.destroy

    self.original_file = file
    self.save!
    Ppt2pdfJob.perform_later(self)
  end
end
