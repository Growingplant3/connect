Rails.application.routes.draw do
  root "homes#index"
  post '/homes/sample_user_sign_in', to: 'homes#sample_user'
  post '/homes/sample_pharmacy_sign_in', to: 'homes#sample_pharmacy'
  post '/homes/developer_sign_in', to: 'homes#developer'
  post '/homes/admin_sign_in', to: 'homes#admin'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, except: %i[new create] do
    resources :medicine_notebook_records do
      resources :prescription_details, except: %i[index show]
    end
  end
  devise_for :pharmacies, controllers: {
    registrations: 'pharmacies/registrations',
    sessions: 'pharmacies/sessions'
  }
  resources :pharmacies, except: %i[new create]
  resources :likes, only: %i[create destroy]
  resources :information_disclosures, only: %i[create destroy]
  resources :medicines, except: [:edit]
  resources :take_method_details, only: %i[index new create destroy]
end
