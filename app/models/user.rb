# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  username            :string(255)      not null
#  remember_created_at :datetime
#  accessed_at         :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  username  (username) UNIQUE
#

class User < ActiveRecord::Base
  devise :registerable, :omniauthable

  # 英数と - _ の 2 つの半角記号を 3-32 文字
  # ただし最初の文字はアルファベット、最後の文字はアルファベットまたは数字であること
  VALID_USERNAME_REGEX = /\A[a-zA-Z][0-9A-Za-z\-_]{1,30}[a-zA-Z0-9]\z/
  validates :username,
            presence: true,
            format: { with: VALID_USERNAME_REGEX, message: :username_regex },
            exclusion: { in: ReservedWord.list }

  has_many :presentations
  has_many :user_accounts, dependent: :destroy, autosave: true

  def image_url
    user_accounts.first.image_url
  end

  def accessed_at_expired?
    accessed_at < Time.current - 1.minute
  end
end
