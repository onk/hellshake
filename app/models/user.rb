# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  remember_created_at :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class User < ActiveRecord::Base
  devise :omniauthable

  has_many :user_accounts, dependent: :destroy
end
