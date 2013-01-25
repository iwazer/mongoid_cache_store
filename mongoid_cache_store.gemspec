# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["iwazer"]
  gem.email         = ["iwazawa@gmail.com"]
  gem.description   = %q{Railsのcache_storeとしてMongoDBを利用できるようにします。MongoDBとの接続にはMongoidをドライバーとして使います}
  gem.summary       = %q{Railsのcache_storeにMongoidからMongoDBを利用できるようにします}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mongoid_cache_store"
  gem.require_paths = ["lib"]
  gem.version       = "0.1.2"

  gem.add_dependency("activesupport", ["~> 3.2"])
  gem.add_dependency("mongoid", ["~> 3.1"])
end
