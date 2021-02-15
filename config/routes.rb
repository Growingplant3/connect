Rails.application.routes.draw do
  root "homes#index"
  post '/homes/sample_user_sign_in', to: 'homes#sample_user'
  post '/homes/sample_pharmacy_sign_in', to: 'homes#sample_pharmacy'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: %i[index show edit update destroy]
  devise_for :pharmacies, controllers: {
    registrations: 'pharmacies/registrations',
    sessions: 'pharmacies/sessions'
  }
  resources :pharmacies, only: %i[index show edit update destroy]
  resources :likes, only: %i[create destroy]
  resources :information_disclosures, only: %i[create destroy]
end
