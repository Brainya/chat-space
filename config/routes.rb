Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'

  resources :groups do
    resources :messages, only: :create
  end
end
