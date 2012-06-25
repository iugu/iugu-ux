module IuguUX
  class Engine < Rails::Engine

    initializer 'iugusdk.action_controller' do |app|
      app.config.assets.precompile += %w( iugu-ux.css iugu-ux.js )
    end

  end
end
