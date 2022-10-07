Rails.application.routes.draw do
  root to: "pages#home"

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :pets do
    resources :services, only: :create
  end

  resources :services, except: %i[new show create]
  resources :users, only: :show
end
