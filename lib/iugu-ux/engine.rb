module IuguUX
  class Engine < Rails::Engine


    initializer 'iugusdk.action_controller' do |app|
      app.config.assets.precompile += %w( iugu-ux.css iugu-ux.js vendor.js )
      # app.config.compass.sprite_load_path << File.join( File.expand_path("../../", __FILE__),'vendor','assets','sprites' )
      app.config.compass.sprite_load_path << app.root.join('app','assets','sprites')
      app.config.compass.sprite_load_path << File.join( File.expand_path("../../..",__FILE__),'vendor','assets','sprites' )
      # app.config.compass.sprite_load_path << 'app/assets/sprites'
      # app.config.compass.sprite_load_path << 'vendor/assets/sprites'
    end

  end
end
