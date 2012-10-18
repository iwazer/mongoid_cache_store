# MongoidCacheStore

Railsのcache_storeとしてMongoDBを利用できるようにします。
MongoDBとの接続にはMongoidをドライバーとして使するので、
Mongoidの設定ファイル（mongoid.yml）で設定されたmongodが使用されます。

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid_cache_store', git: 'git://github.com/iwazer/mongoid_cache_store.git'

And then execute:

    $ bundle

<!--
Or install it yourself as:

    $ gem install mongoid_cache_store
-->

## Usage

設定ファイル `config/environments/production.rb`に`cache_store`指定を行います。
（開発モード時にも動作を確認したい場合は`development.rb`にも設定の上、
`config.action_controller.perform_caching`を`true`にする必要があります）

```ruby
config.cache_store = MongoidCacheStore.new(collection_name: 'hoge_cache_store', database_name: 'hoge_cache_db')
```

`collection_name`を省略すると`"rails_cache_store"`を使用します。
`database_name`を省略するとmongoid.ymlの設定値を使用します。

<!--
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
-->
