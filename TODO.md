TODO
================================

-   [x] 何もかも諦めて最初から Rails 使うぞ！
-   [x] pdf のスライドを web 上で見られる
    -   pdf.js を用いればできそう
        -   サンプル
            * https://github.com/mrraj/pdfjs
            * https://github.com/concordia-publishing-house/pdfjs-rails
            * https://github.com/shyammohankanojia/pdfjs_rails
            * https://github.com/senny/pdfjs_viewer-rails
-   [ ] ppt/pptx のスライドを web 上で見られる
    -   libreoffice --headless を用いて ppt/pptx を pdf に変換すればできそう
        -   コマンドメモ
            `soffice --headless --convert-to pdf [--outdir ./out] 20141101_すこやかRails.pptx`
    -   変換時に job queue が必要そうなので sidekiq かなぁ
-   [ ] サムネイル表示
    -   ImageMagick で pdf から png にできるので瞬殺っぽい
-   [ ] ppt/pptx/pdf の中のテキストで検索
    -   コマンドメモ
        `pdftotext -nopgbrk 20141101_すこやかRails.pdf -`
    -   変換したら ElasticSearch に流し込もう
        -   author で絞って検索
        -   title で絞って検索
        -   created_at で絞って検索
-   [ ] markdown で文章を書いたら自動的にスライドになる
    -   presenter (pdf/markdown) の切り替えが必要になって面倒
    -   サービスの方針に合わなかったらオミットするかもー
-   [ ] 投稿時の private オプション
    -   変換後の出来を確認してから投稿したいよねぇ
