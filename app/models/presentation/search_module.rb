module Presentation::SearchModule
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    settings index: {
      analysis: {
        filter: {
          pos_filter: {
            type: "kuromoji_part_of_speech",
            stopgaps: ["助詞-格助詞-一般", "助詞-終助詞"],
          },
          greek_lowercase_filter: {
            type: "lowercase",
            language: "greek",
          },
        },
        analyzer: {
          kuromoji_analyzer: {
            type: "custom",
            tokenizer: "kuromoji_tokenizer",
            mode: "extended",
            filter: %w(kuromoji_baseform pos_filter greek_lowercase_filter cjk_width),
          }
        },
      }
    }
    mapping do
      indexes :title,   analyzer: :kuromoji_analyzer
      indexes :outline, analyzer: :kuromoji_analyzer
      indexes :tags,    analyzer: :kuromoji_analyzer
    end
  end

  def as_indexed_json(_options = {})
    if is_public
      {
        username: user.username,
        title: title,
        outline: presentation_outline.try(:body),
        tags: tag_list,
      }
    else
      {}
    end
  end
end
