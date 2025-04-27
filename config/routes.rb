Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'  # 'items#index' はコントローラーとアクションに応じて変更します
  resources :items, only: [:new, :create, :show,:edit,:update,:destroy] # 'new'アクションへのルートを追加

end