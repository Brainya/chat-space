Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'

  resources :groups do
    resources :messages, only: [:index, :create] do
      collection do
        get 'set_update_time'
      end
    end
  end
end
