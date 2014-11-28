Rails.application.routes.draw do
  root to: 'events#index'

  post 'text', to: 'sms/inbound_messages#create'

  resources :events do
    member do
      post :activate
      post :deactivate
    end

    resources :attendances
  end

  resource :user

  # Authentication
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  resource :boom
end
