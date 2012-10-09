require 'haml-rails'
require 'compass-rails'

module IuguUX
  class Engine < Rails::Engine
      initializer 'iugu-ux.setup' do |app|
        app.config.assets.precompile += IuguUX.src
        app.config.compass.sprite_load_path << app.root.join('app','assets','sprites')
        app.config.compass.sprite_load_path << IuguUX.sprite_load_path 
      end

  end
end
