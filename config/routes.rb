Rails.application.routes.draw do
  devise_for :users
  get "show", to: "shop_list#show"
  get 'static_pages/home'
  #root 'static_pages#home'
  root 'shop_list#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
