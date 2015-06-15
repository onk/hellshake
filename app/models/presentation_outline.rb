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
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :presentation

  settings index: {
    analysis: {
      filter: {
        pos_filter: {
          type: "kuromoji_part_of_speech",
          stopgaps: ["助詞-格助詞-一般", "助詞-終助詞"]
        },
        greek_lowercase_filter: {
          type: "lowercase",
          language: "greek"
        }
      },
      analyzer: {
        kuromoji_analyzer: {
          type: "custom",
          tokenizer: "kuromoji_tokenizer",
          mode: "extended",
          filter: %w(kuromoji_baseform pos_filter greek_lowercase_filter cjk_width)
        }
      }
    }
  }
  mapping do
    indexes :body, analyzer: :kuromoji_analyzer
  end
end
