Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
        get '/:id/revenue', to: 'revenue#show'
        get '/most_items', to: 'item#index'
        get '/revenue', to: 'daterevenue#show'
      end
      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
        get '/most_revenue', to: 'revenue#index'
        get '/most_items', to: 'total#index'
      end
      resources :items, only: [:index, :show] do
        get 'invoice_items', to: 'invoice_items#index'
        get 'merchant', to: 'merchants#show'
      end

      namespace :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :invoices, only: [:index, :show] do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
        resources :items, only: [:index]
        get '/customer', to: 'customers#show'
        get '/merchant', to: 'merchants#show'
      end

      namespace :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :invoice_items, only: [:index, :show] do
        get '/invoice', to: 'invoices#show'
        get '/item', to: 'items#show'
      end

      namespace :transactions do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'search#show'
      end
      resources :transactions, only: [:index, :show] do
        get '/invoice', to: 'invoices#show'
      end
    end
  end
end
