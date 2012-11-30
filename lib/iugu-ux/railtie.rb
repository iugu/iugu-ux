require 'haml-rails'
require 'compass-rails'

module IuguUX
  class Engine < Rails::Engine
      initializer 'iugu-ux.setup' do |app|
        if app.consig.assets
          app.config.assets.precompile += IuguUX.src
        end
        if app.config.compass
          app.config.compass.sprite_load_path << app.root.join('app','assets','sprites')
          app.config.compass.sprite_load_path << IuguUX.sprite_load_path 
          app.config.compass.add_import_path File.join( IuguUX.assets_path, 'stylesheets' )
        end
        if app.config.sass
          app.config.sass.load_paths << File.join( IuguUX.assets_path, 'stylesheets' )
          app.config.sass.load_paths << File.join( IuguUX.assets_path, 'stylesheets', 'iugu-ux' )
          app.config.sass.load_paths << File.join( IuguUX.assets_path, 'stylesheets', 'iugu-ux', 'google-code-prettify' )
        end
      end

  end
end
