# -*- encoding: utf-8 -*-
require File.expand_path('../lib/clwy-omniauth-qq/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Liu Dong"]
  gem.email         = ["support@clwy.cn"]
  gem.description   = %q{OmniAuth strategies for TQQ and QQ Connect).}
  gem.summary       = %q{OmniAuth strategies for TQQ and QQ Connect).}
  gem.homepage      = "https://github.com/clwy-cn/clwy-omniauth-qq"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "clwy-omniauth-qq"
  gem.require_paths = ["lib"]
  gem.version       = ClwyOmniauth::QQ::VERSION

  gem.add_dependency 'omniauth', '~> 2.0'
  gem.add_dependency 'omniauth-oauth', '~> 1.2'
  gem.add_dependency 'omniauth-oauth2', '~> 1.8'
  gem.add_dependency 'multi_json'
end
