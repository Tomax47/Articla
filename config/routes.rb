Rails.application.routes.draw do
  get 'sessions/new'
  get 'users/new'

  resources :posts do
    resources :comments, only: [:destroy,:create]

  end

  resources :users, only: [:create]
  get 'users/new'
  get '/register', to: 'users#new'


  resources :sessions, only: [:create]
  get 'sessions/new'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'


  root 'posts#index'

end
