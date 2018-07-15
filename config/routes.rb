Rails.application.routes.draw do

    root to: 'questions#index'

    devise_for :users, :controllers => { registrations: 'registrations' }
    resources :questions, except: [:destroy] do
        get "evaluate_question"
        post "update_question_review"
    end


end