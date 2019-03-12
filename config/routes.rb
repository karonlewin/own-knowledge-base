Rails.application.routes.draw do
  resources :categories
  devise_for :users
  root to: 'dashboard#index', as: :dashboard
  resources :annotations

  put '/mark_review_as_done/:id' => 'reviews#mark_as_done', as: 'mark_review_as_done'
  get '/mark_all_reviews_as_done' => 'reviews#mark_all_reviews_as_done', as: 'mark_all_reviews_as_done'
  get '/randomize_non_reviewed' => 'reviews#randomize_non_reviewed', as: 'randomize_non_reviewed'

  get '/testing_email' => 'dashboard#testing_email', as: 'testing_email'
end
