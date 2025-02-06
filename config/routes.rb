Rails.application.routes.draw do
  resources :admins
  resources :saved_projects
  resources :applications
  resources :students
  resources :project_faculties # This one doesn't have a controller, its handled by other models.
  resources :faculties
  resources :projects

  root "projects#index"
  # get "admins/index"
  # get "admins/show"
  # get "admins/new"
  # get "admins/create"
  # get "saved_projects/index"
  # get "saved_projects/show"
  # get "saved_projects/new"
  # get "saved_projects/create"
  # get "saved_projects/edit"
  # get "saved_projects/update"
  # get "saved_projects/destroy"
  # get "applications/index"
  # get "applications/show"
  # get "applications/new"
  # get "applications/create"
  # get "applications/edit"
  # get "applications/update"
  # get "applications/destroy"
  # get "students/index"
  # get "students/show"
  # get "students/new"
  # get "students/create"
  # get "students/edit"
  # get "students/update"
  # get "students/destroy"
  # get "faculties/index"
  # get "faculties/show"
  # get "faculties/new"
  # get "faculties/create"
  # get "faculties/edit"
  # get "faculties/update"
  # get "faculties/destroy"
  # get "projects/index"
  # get "projects/show"
  # get "projects/new"
  # get "projects/create"
  # get "projects/edit"
  # get "projects/update"
  # get "projects/destroy"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
