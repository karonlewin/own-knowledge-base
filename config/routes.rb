Rails.application.routes.draw do
  root to: 'dashboard#index', as: :dashboard
  resources :annotations

end
