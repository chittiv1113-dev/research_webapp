Rails.application.routes.draw do
  resources :faculties do
    # Nested projects under the faculty
    resources :projects
  end
  # Allow studnets to view projects
  resources :projects, only: %i[index show]
  # Applicatoins nested under students
  resources :students do
    resources :applications
  end

  # Root page set to projects index
  root 'projects#index'
end
