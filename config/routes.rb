Rails.application.routes.draw do
  root "homes#index"
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: %i[show edit update]
end
