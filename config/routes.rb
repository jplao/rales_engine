Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random.json', to: 'search#show'
        get '/:id/revenue', to: 'revenue#show'
      end

      resources :merchants, only: [:index, :show]

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random.json', to: 'search#show'
      end
      resources :items, only: [:index, :show]
    end
  end
end
