Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [:index]
      resources :posts, only: [:index] do
        resources :comments, only: [:show, :index, :create]
      end
      match '*path', to: 'base#render_not_found', via: [:get, :post]
    end
  end
end
