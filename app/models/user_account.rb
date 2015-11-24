# == Schema Information
#
# Table name: user_accounts
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  provider         :string(255)      not null
#  uid              :string(255)      not null
#  token            :string(511)      not null
#  token_secret     :string(255)
#  token_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  provider_and_uid      (provider,uid) UNIQUE
#  user_id_and_provider  (user_id,provider) UNIQUE
#

class UserAccount < ActiveRecord::Base
  belongs_to :user

  def save_auth_info(omniauth)
    self.token = omniauth["credentials"]["token"]
    if omniauth["credentials"]["expires_at"]
      self.token_expires_at = Time.at(omniauth["credentials"]["expires_at"])
    end
    self.save!
  end
end
