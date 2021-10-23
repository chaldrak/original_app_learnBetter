Rails.application.routes.draw do
  
  get 'answers/create'

  resources :questions do
    collection do
      post :confirm
    end
    resources :comments
    resources :answers
  end

  resources :answers, only: %i[] do
    resources :comments, only: %i[ new create update edit destroy ]
  end

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
