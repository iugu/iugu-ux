Dummy::Application.routes.draw do
  root :to => 'ui_library#index'
  get "components" => "ui_library#components"
end
