# inspired by zipang gem
# kuromoji に依存したくなかったので natto ベースで書き換えた
#
# @see
# https://github.com/halenohi/zipang
# https://github.com/buruzaemon/natto/wiki/%E6%8C%AF%E3%82%8A%E4%BB%AE%E5%90%8D%E5%A4%89%E6%8F%9B
module Zipang
  # 半角空白、全角空白、アンスコを区切り文字とみなす
  GLUE_REGEX = /([[:space:]]|_)+/
  GLUE = "-".freeze

  def self.to_slug(str)
    word_arr = []
    Natto::MeCab.new.parse(sanitize(str)) do |n|
      unless n.is_eos?
        kana = n.feature.split(",")[7] # 7th は読み仮名(ChaSen)
        word_arr << (kana.presence || n.surface)
      end
    end

    # 英数 -_ に合致しない文字列は取り除く
    word_arr.map { |w| Romaji.kana2romaji(w) }.join(GLUE).gsub(/[^0-9A-Za-z\-_]/, "").squeeze(GLUE)
  end

  # 全角数字を Natto に通すと １ => イチ になるので半角数字に
  # 全角空白を Natto に通すと処理が面倒なので半角空白に
  # アンスコは区切り文字扱いにしたいので半角空白に
  def self.sanitize(str)
    str.tr("０-９", "0-9").gsub(GLUE_REGEX, " ")
  end
end
