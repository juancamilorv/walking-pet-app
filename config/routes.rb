Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :pets do
    resources :services, only: %i[new create]
  end

  resources :services, except: %i[new create destroy]
end
