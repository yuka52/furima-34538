Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    collection do
      get 'listed'
    end
    resources :orders, only: [:index, :create]
  end
end
