require 'haml'
require 'compass'

require "iugu-ux/railtie" if defined?(::Rails)

require "iugu-ux/version"

module IuguUX

  def self.src
    @@src
  end

  def self.src=(src)
    @@src = src
  end

  self.src = %w( iugu-ux.css iugu-ux.js vendor.js )

  class << self
    def sprite_load_path
      File.join( File.expand_path("../..",__FILE__),'vendor','assets','sprites')
    end

    def root
      File.join( File.expand_path("../..",__FILE__))
    end

    def assets_path
      File.join( File.expand_path("../..",__FILE__),'vendor','assets')
    end
  end

  def initialize
  end

  def self.setup
    yield self
  end

end
