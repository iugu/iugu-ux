Dummy::Application.routes.draw do
  root :to => 'ui_library#index'
  get "components" => "ui_library#components"
  get "boiler" => "ui_library#boiler"
  get "mediaquery" => "ui_library#mediaquery"
end
