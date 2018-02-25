HellShake
================================

clone of slideshare.net

System dependencies
--------------------------------

* ruby v2.4+
    * bundler
* mysql v5.7+
* memcached v1.5+
* redis v4.0+
* elasticsearch v5.5+
* nodejs 8.7+
    * npm
* mecab

* libreoffice (if you need to upload ppt/pptx)
* poppler (pdftotext,pdftocario)

[https://github.com/onk/hellshake/blob/master/INSTALL.md](https://github.com/onk/hellshake/blob/master/INSTALL.md)

How to setup
--------------------------------

### Install

```sh
$ git clone https://github.com/onk/hellshake.git
$ cd hellshake
$ bundle install
$ npm install
$ bundle exec rake bower:install
```

### Configure database

```
$ cp config/database.yml.sample config/database.yml
```

### Setup database

```
$ bundle exec rake db:create
$ bundle exec rake db:migrate
$ bundle exec rake db:seed
```

### Start servers

```
$ bundle exec rails server
$ bundle exec sidekiq -v
```

And access [http://localhost:3000/](http://localhost:3000/)


## License

The application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
