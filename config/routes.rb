Rails.application.routes.draw do
  
  get 'answers/create'

  resources :questions do
    member do
      patch :set_good_answer
    end
    collection do
      post :confirm
    end
    resources :comments
    resources :answers
  end

  resources :favorites, only: [:create, :destroy]

  resources :votes, only: [:create, :update, :destory]

  resources :answers, only: %i[] do
    resources :comments, only: %i[ new create update edit destroy ]
    member do
      post :vote_answer
    end
  end

  resources :conversations, only: [:index, :create] do
    resources :messages
  end

  resources :users, only: [:update, :show, :index]

  root 'questions#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/inbox"
  end

  devise_for :users, path: 'auth', 
            path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', sign_up: 'register' },
            controllers: {
              registrations: "users/registrations",
              omniauth_callbacks: "users/omniauth_callbacks"
            }

end
