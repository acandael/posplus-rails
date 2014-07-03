Rails.application.routes.draw do
  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :research_themes
    resources :research_projects, only: [:index, :show, :new, :create, :edit, :update]
  end
end
