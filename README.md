ShareDoc
================================

clone of slideshade.net

System dependencies
--------------------------------

* ruby v2.0 以上
    * bundler
* mysql v5.x 以上
* memcached v1.4 以上
* redis v2.8 以上
* elasticsearch v1.x with kuromoji plugin もしくは v2.x 以上
* nodejs 0.10.x 以上
    * npm
* mecab

* libreoffice (pdf のみアップロードするなら不要)
* poppler (pdftotext,pdftocario)

[https://github.com/onk/sharedoc/blob/master/INSTALL.md](https://github.com/onk/sharedoc/blob/master/INSTALL.md)

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
