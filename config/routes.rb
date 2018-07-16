Rails.application.routes.draw do

  root to: 'questions#index'

  devise_for :users, :controllers => { registrations: 'registrations' }
  resources :questions, except: [:destroy] do
      get "evaluate_question"
      post "update_question_review"
  end

  #custom error pages
  match '/404', to: 'application#not_found', via: :all
  match '/500', to: 'application#internal_server_error', via: :all


end