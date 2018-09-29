Rails.application.routes.draw do
  get 'films/index'
  get 'films/show'
  root 'static_pages#home'
  resources :films


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
