Rails.application.routes.draw do

  resources :user_stocks, only: [:create, :destroy]
  devise_for :users
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'my_friends', to: 'users#my_friends'
  get 'search_friend', to: 'users#search'

  get 'unfriend', to: 'users#search'
  post 'add_to_my_portfolio', to: 'user_stocks#add_to_portfolio'

  resources :friendships, only: [:create, :destroy]
  resources :users, only: [:show]

end
