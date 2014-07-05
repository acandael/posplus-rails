Rails.application.routes.draw do
  root to: "homes#index"

  get 'home', to: "homes#index"

  get 'sign_in' => "sessions#new"
  resource :session

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :research_themes
    resources :research_projects
  end
end
