# Current Gem versions to Work

compass => 0.13.alpha
sass => Auto Request Alpha

Example:

group :assets do
  gem 'sass'
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'compass', "~> 0.13.alpha"
  gem 'compass-rails'

  gem 'eco'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'iugusdk', :path => "../iugusdk"
gem 'haml'
gem 'haml-rails'
gem 'coffee-script'
gem 'iugu-ux', :path => "../iugu-ux"
