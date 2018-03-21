module Presentation::SearchModule
  extend ActiveSupport::Concern

  included do # rubocop:disable Metrics/BlockLength ElasticSearch の index 定義なので無理
    include Elasticsearch::Model

    # update_document は changed_attributes に依存していて罠が多いので
    # Elasticsearch::Model::Callbacks を include せずに index_document を呼ぶ
    after_commit -> { __elasticsearch__.index_document },  on: :create
    after_commit -> { __elasticsearch__.index_document },  on: :update
    after_commit -> { __elasticsearch__.delete_document }, on: :destroy

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
            filter: %w[kuromoji_baseform pos_filter greek_lowercase_filter cjk_width],
          },
        },
      },
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
