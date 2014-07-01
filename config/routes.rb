Rails.application.routes.draw do
  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :research_themes, only: [:index]
  end
end
