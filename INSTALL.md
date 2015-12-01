INSTALL
================================

mac での環境構築方法 (だいたい homebrew で入る)

ruby
--------------------------------

2.2.3 or later 推奨

```sh
$ brew install ruby
```

mysql
--------------------------------

```sh
$ brew install mysql
```

memcached
--------------------------------

揮発性の KVS。session の保存に使っている

```sh
$ brew install memcached
```

redis
--------------------------------

KVS。sidekiq (非同期処理) の queue と、アクセスカウンタに使っている。

```sh
$ brew install redis
```

elasticsearch
--------------------------------

全文検索エンジン

```sh
$ brew install elasticsearch
```

nodejs
--------------------------------

js/css 周りに bower を使っている

```sh
$ brew install nodejs
```

libreoffice
--------------------------------

ppt -> pdf の変換に利用

brew cask で入れます。デフォルトだと "~/Application" に配備されるので
必要に応じて環境変数 `HOMEBREW_CASK_OPTS` で `--appdir` を指定してください。

気にならなければ未指定で OK。

```sh
$ brew install Caskroom/cask/libreoffice
```

poppler
--------------------------------

pdf をテキストにしたり画像にしたり

```sh
$ brew install poppler
```

mecab
--------------------------------

文字列の形態素解析

```sh
$ brew install mecab
$ brew install mecab-ipadic
```
