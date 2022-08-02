Rails.application.routes.draw do
  devise_for :users
  #get "show", to: "shop_list#show"
  # get 'static_pages/home'
  #root 'static_pages#home' #そのうちコントローラーごと削除する
  root 'shop_list#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'config/base', to: 'bases#show'
  post 'config/base/update', to: 'bases#create'

  get  'memos/:place_id', to: 'memos#show'
  post 'memos/update', to: 'memos#update'
end
