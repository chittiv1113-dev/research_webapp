Rails.application.routes.draw do
  # get "projects/index"
  root to: "projects#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    get "users/sign_in", to: "users/sessions#new", as: :new_user_session
    get "users/sign_out", to: "users/sessions#destroy", as: :destroy_user_session
  end

  resources :projects, only: [ :index, :new, :create, :edit, :update, :destroy, :show ] # Add edit, update, and destroy

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  resources :faculties
  resources :students
  get "admin_dashboard" => "admins#dashboard", as: :admin_dashboard

  post "forms/send_form/:project_id", to: "forms#send_form", as: "send_form"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
