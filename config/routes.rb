Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      get 'items/search_all', to: 'items/search#search_all'
      get 'merchants/search', to: 'merchants/search#search'
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: 'merchants/items'
      end
      resources :items do
        member do
          get 'merchant', to: 'items/merchants#show'
        end
      end
    end
  end
end
