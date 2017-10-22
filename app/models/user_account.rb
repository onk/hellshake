# == Schema Information
#
# Table name: user_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  image_url  :string(255)
#  raw_info   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  provider_and_uid      (provider,uid) UNIQUE
#  user_id_and_provider  (user_id,provider) UNIQUE
#

class UserAccount < ActiveRecord::Base
  belongs_to :user

  def build_auth_info(omniauth)
    self.image_url = omniauth["info"]["image"]
    self.raw_info  = omniauth["extra"]["raw_info"].to_json
  end

  def save_auth_info(omniauth)
    build_auth_info(omniauth)
    self.save!
  end
end
