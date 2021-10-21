Rails.application.routes.draw do
  root 'home#index'

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
