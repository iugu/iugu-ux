# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "iugu-ux/version"

Gem::Specification.new do |s|
  s.name        = "iugu-ux"
  s.version     = IuguUX::VERSION
  s.authors     = ["Patrick Negri"]
  s.email       = ["patrick@iugu.com.br"]
  s.homepage    = ""
  s.summary     = %q{Iugu UX Library}
  s.description = %q{Iugu Typografy and Components for HTML5,CSS,JS}

  s.rubyforge_project = "iugu-ux"

  s.files = Dir["README.md", "LICENSE", "Rakefile", "app/**/*", "lib/**/*", "vendor/**/*"]
  s.test_files = Dir["sandbox/**/*"]
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  # s.add_dependency             'railties',   '>= 3.1'
  # s.add_dependency             'actionpack', '>= 3.1'

  s.add_development_dependency "rails", ">= 3.1"
  s.add_dependency "railties", ">= 3.1.0"
  s.add_dependency 'coffee-script'
  s.add_dependency 'sass-rails'
  s.add_dependency 'haml'
  s.add_dependency 'haml-rails'
  s.add_dependency 'compass'
  s.add_dependency 'compass-rails'

end
