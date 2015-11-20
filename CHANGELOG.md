## master (unreleased)
[full changelog](https://github.com/onk/sharedoc/compare/v0.8.2...master)

## v0.8.2 (2015-11-20)
[full changelog](https://github.com/onk/sharedoc/compare/v0.8.1...v0.8.2)

*   pdf をアップロードしたときにエラーになる不具合修正

## v0.8.1 (2015-11-18)
[full changelog](https://github.com/onk/sharedoc/compare/v0.8.0...v0.8.1)

*   ログインフォーム改善
*   ログイン状態を維持するように

## v0.8.0 (2015-10-07)
[full changelog](https://github.com/onk/sharedoc/compare/v0.7.3...v0.8.0)

*   ユーザの accessed_at を記録する
*   Pdf2outlineJob を再実行可能に
*   資料を URL を保ったまま再アップロードできるように

## v0.7.3 (2015-09-29)
[full changelog](https://github.com/onk/sharedoc/compare/v0.7.2...v0.7.3)

*   atom 配信の不具合修正
*   gem もろもろ最新化

## v0.7.2 (2015-08-14)
[full changelog](https://github.com/onk/sharedoc/compare/v0.7.1...v0.7.2)

*   atom 配信

## v0.7.1 (2015-08-08)
[full changelog](https://github.com/onk/sharedoc/compare/v0.7.0...v0.7.1)

*   検索結果のページネートを実装

## v0.7.0 (2015-08-05)
[full changelog](https://github.com/onk/sharedoc/compare/v0.6.1...v0.7.0)

*   outline だけじゃなく tag や title でも検索できるように

## v0.6.1 (2015-08-03)
[full changelog](https://github.com/onk/sharedoc/compare/v0.6.0...v0.6.1)

*   タグ検索時に is_public フラグが効いていなかった

## v0.6.0 (2015-08-03)
[full changelog](https://github.com/onk/sharedoc/compare/v0.5.3...v0.6.0)

*   プレゼンを削除できる機能を追加
*   アクセス数を取得しておく (まだユーザには見せない)

## v0.5.3 (2015-07-31)
[full changelog](https://github.com/onk/sharedoc/compare/v0.5.2...v0.5.3)

*   copy fonts to public path
*   DB のパスワードをコミットしないようにする
*   表紙画像の横幅 250px の方がかわいい

## v0.5.2 (2015-07-29)
[full changelog](https://github.com/onk/sharedoc/compare/v0.5.1...v0.5.2)

*   スマホで見た時用に viewport 指定入れる
*   名前の全角空白が気になりすぎるので半角スペースに置換
*   プレゼン上に乗ってる名前が読めないので css 修正
*   validation error を分かりやすくする

## v0.5.1 (2015-07-28)
[full changelog](https://github.com/onk/sharedoc/compare/v0.5.0...v0.5.1)

*   zipang の生成ルールと slug の validation とを合わせる
*   tag 検索の表示順を published_at desc に修正

## v0.5.0 (2015-07-27)
[full changelog](https://github.com/onk/sharedoc/compare/v0.4.0...v0.5.0)

*   詳細ページから "Open File" ボタンを隠す
*   タグ検索機能を実装

## v0.4.0 (2015-07-24)
[full changelog](https://github.com/onk/sharedoc/compare/v0.3.1...v0.4.0)

*   タグ機能を追加
*   非公開のスライドを表示しようとするとエラーになるのでリンク削除
*   入力エラー時にエラーを目立たせた

## v0.3.1 (2015-07-23)
[full changelog](https://github.com/onk/sharedoc/compare/v0.3.0...v0.3.1)

*   フォームの label を localize して分かりやすく
*   slug の validation 追加

## v0.3.0 (2015-07-23)
[full changelog](https://github.com/onk/sharedoc/compare/v0.2.0...v0.3.0)

*   詳細ページの URL を human readable に

## v0.2.0 (2015-07-22)
[full changelog](https://github.com/onk/sharedoc/compare/v0.1.0...v0.2.0)

*   use simple_form gem
*   タイトルを入力できるようにした
*   プレゼン一覧画面に gravatar 追加
*   materialize css framework を使う
*   変換中画像を用意した
*   投稿日時を設定可能にした
*   デプロイ時に vendor/assets/bower_components を維持する
*   投稿日時順表示と paginate を実装
*   PDF.js モロパクリの pdf 表示にした

## v0.1.0 (2015-07-06)

*  Initial Release
