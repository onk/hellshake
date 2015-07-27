# == Schema Information
#
# Table name: presentation_outlines
#
#  id              :integer          not null, primary key
#  presentation_id :integer          not null
#  body            :text(16777215)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  presentation_id  (presentation_id) UNIQUE
#

class PresentationOutline < ActiveRecord::Base
  belongs_to :presentation
end
