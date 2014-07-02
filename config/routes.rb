Rails.application.routes.draw do
  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :research_themes
  end
end
