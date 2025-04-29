# config/routes.rb
Rails.application.routes.draw do
  get "help/show"
  # --- NEW: Set root to the landing page ---
  root to: "applications#landing"

  # Devise routes (keep as is)
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  devise_scope :user do
    get "users/sign_in", to: "users/sessions#new", as: :new_user_session
    get "users/sign_out", to: "users/sessions#destroy", as: :destroy_user_session
  end

  # --- UPDATED: Nest applications under projects ---
  resources :projects, only: [ :index, :new, :create, :edit, :update, :destroy, :show ] do
    resources :applications, only: [ :new, :create ] # Creates new_project_application_path and project_applications_path
  end

  # Admin, Faculty, Student routes (keep as is)
  resources :admins, only: [ :index, :new, :create, :edit, :update, :destroy ]
  get "admin_dashboard" => "admins#dashboard", as: :admin_dashboard
 # --- UPDATED: Documentation Routes ---
  # Renamed route helper for clarity, path remains /documentation
  get "documentation" => "pages#documentation", as: :admin_dashboard_documentation
  # New route for role-specific help pages
  get "help" => "help#show", as: :help
  resources :faculties
  resources :students

  # Health check (keep as is)
  get "up" => "rails/health#show", as: :rails_health_check

  # --- REMOVE old form route if it exists ---
  # post "forms/send_form/:project_id", to: "forms#send_form", as: "send_form" # Remove this line
end
