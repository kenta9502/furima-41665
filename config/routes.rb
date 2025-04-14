Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'  # 'items#index' はコントローラーとアクションに応じて変更します
  resources :items, only: [:new, :create] # 'new'アクションへのルートを追加
  get 'login', to: 'sessions#new', as: 'login'
  delete 'logout', to: 'sessions#destroy', as: 'logout'


end