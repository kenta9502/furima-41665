Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'  # 'items#index' はコントローラーとアクションに応じて変更します
  resources :items, only: [:new, :create, :show] # 'new'アクションへのルートを追加
  resources :products

end