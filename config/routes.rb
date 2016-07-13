require 'sidekiq/web'
require 'sidekiq-status/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  post "ai", to: "ai#index"
  put "user/:id/preference", to: "preference#update"
  get "user/:id/preference", to: "preference#index"
  resources :notifications do
    collection do
      post :receive
      get :users_slack_info
    end
  end

  mount Sidekiq::Web => '/sidekiq'

end
