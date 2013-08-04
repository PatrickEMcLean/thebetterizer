Betterizer::Application.routes.draw do
  root :to => 'home#index'
  match "/about" => "home#about"
  match "/auth/:provider/callback" => "sessions#create"
  match "/signout" => "sessions#destroy", :as => :signout

  resources :works
end
