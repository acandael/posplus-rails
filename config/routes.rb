Rails.application.routes.draw do
  root to: "homes#index"

  get 'home', to: "homes#index"

  get 'signin' => "sessions#new"
  resource :session

  resources :people, only: [:index, :show]
  resources :research, only: [:index]
  resources :research_themes, only: [:show]
  resources :research_projects, only: [:show]
  resources :news_items, only: [:show]

  get 'admin', to: 'dashboard#index'
  namespace :admin do
    resources :research_themes
    resources :research_projects
    resources :researchers
    resources :courses
    resources :news_items
    resources :publications
  end
end
