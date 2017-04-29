Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'

  resources :groups do
    resources :messages, only: [:index, :create]
    collection do
      get :ajax_user_list
    end
    member do
      get :ajax_user_list
    end
  end
end
