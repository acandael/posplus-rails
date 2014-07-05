Rails.application.routes.draw do

  get 'sign_in' => "sessions#new"
  resources :sessions, only: [:create]

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :research_themes
    resources :research_projects
  end
end
