Rails.application.routes.draw do
  root to: "homes#index"

  get 'home', to: "homes#index"

  get 'signin' => "sessions#new"
  resource :session

  get 'admin', to: 'dashboard#index'
  namespace :admin do
    resources :research_themes
    resources :research_projects
    resources :researchers, only: [:index, :show, :new, :create]
  end
end
