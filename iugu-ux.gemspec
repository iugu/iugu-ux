# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "iugu-ux/version"

Gem::Specification.new do |s|
  s.name        = "iugu-ux"
  s.version     = IuguUX::VERSION
  s.authors     = ["Patrick Negri"]
  s.email       = ["support@iugu.com"]
  s.homepage    = ""
  s.summary     = %q{Iugu UX Library}
  s.description = %q{Iugu User Experience and Components for HTML5,CSS,JS}

  s.rubyforge_project = "iugu-ux"

  s.files = Dir["README.md", "LICENSE", "Rakefile", "app/**/*", "lib/**/*", "vendor/**/*"]
  s.test_files = Dir["sandbox/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency 'coffee-script'
  s.add_dependency 'sass', "3.2.9"
  s.add_dependency 'eco'
  s.add_dependency 'haml'
  s.add_dependency 'compass'

  s.add_development_dependency 'bundler', ['>= 1.0.0']
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'haml-rails'
  s.add_development_dependency 'compass-rails'
  s.add_development_dependency 'jquery-rails'
  s.add_development_dependency 'railties', "~> 3.1"
  s.add_development_dependency 'rails', "~> 3.2.6"
  #s.add_development_dependency 'uglifier'
  s.add_development_dependency 'closure-compiler'

end
