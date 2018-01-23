Rails.application.routes.draw do
  get 'profile/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
end
