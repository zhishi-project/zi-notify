require 'sidekiq/web'
require 'sidekiq-status/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  post "ai", to: "ai#index"
  put "user/preference/update", to: "preference#update"
  resources :notifications do
    collection do
      post :receive
    end
  end

  mount Sidekiq::Web => '/sidekiq'

end
