Rails.application.routes.draw do
  mount RailsWarp::Engine => "/rails_warp"

  resources :users, only: [:index, :show, :create] do
    collection do
      get :error
      get :with_partial
    end
    member do
      get :single_with_partial
    end
  end
end
