Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords:'users/passwords',
    registrations:'users/registrations'
  }
  get 'hospitals/:hospital_id/appointments/:id/accept', to: 'appointments#accept', as: 'accept_hospital_appointment'
  get 'hospitals/:hospital_id/appointments/:id/reject', to: 'appointments#reject', as: 'reject_hospital_appointment'
  resources :hospitals do
    resources :hospital_treatments
  end

  get 'approve_user/:id', to: 'admin#approve_user', as: 'approve_user'
  get 'reject_user/:id', to: 'admin#reject_user', as: 'reject_user'
  get 'unapproved_users', to: 'admin#unapproved_users', as: 'unapproved_users'

  resources :hospitals do
    resources :treatments

    resources :doctors do
      get :add_doctor, :remove_doctor
    end
    resources :assignts do
      post :assign_treatment
      get  :unassign_treatment
    end
    resources :appointments do
      member do
        put :accept
        put :reject
      end
    end
  end
  root 'hospitals#index'
end






