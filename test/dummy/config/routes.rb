Rails.application.routes.draw do
  mount RailsWarp::Engine => "/rails_warp"
  # resources: :users, only: [:index, :show, :create]
  resources :users, only: [:index, :show, :create]
end
