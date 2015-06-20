ShareDoc
================================

clone of slideshade.net

System dependencies
--------------------------------

* ruby v2.2.x
    * bundler
* mysql v5.x
* memcached v1.4
* redis v3.x
* elasticsearch v1.5
    * kuromoji analysis plugin v2.5.0
* nodejs 0.10.x
    * npm

* libreoffice (pdf のみアップロードするなら不要)
* poppler (pdftotext,pdftocario)

How to setup
--------------------------------

### インストール

```sh
$ git clone https://github.com/onk/sharedoc.git
$ cd sharedoc
$ bundle install
$ npm install
$ bundle exec rake bower:install
```

### 環境毎の設定をする

コピーし、必要に応じて変更する。

```
$ cp config/database.yml.sample config/database.yml
```

### DB作成, 初期データ投入

```
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```

### サーバ起動

```
$ bundle exec rails server
$ bundle exec sidekiq -v
```

[http://localhost:3000/](http://localhost:3000/) にアクセスする
