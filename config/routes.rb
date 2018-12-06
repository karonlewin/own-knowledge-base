Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root to: 'dashboard#index', as: :dashboard
  resources :annotations

  put '/mark_review_as_done/:id' => 'reviews#mark_as_done', as: 'mark_review_as_done'
end
