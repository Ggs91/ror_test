Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [:index]
      resources :posts, only: [:index] do
        resources :likes, only: [:create], module: :posts
        resources :comments, only: [:index, :create] do
          resources :likes, only: [:create], module: :comments
        end
      end
      match '*path', to: 'base#render_not_found', via: [:get, :post]
    end
  end
end
