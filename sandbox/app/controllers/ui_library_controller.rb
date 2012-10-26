class UiLibraryController < ApplicationController

  layout 'ui'
  
  def index
  end

  def components
  end

  def boiler
    render :layout => false
  end

  def mediaquery
  end

end
