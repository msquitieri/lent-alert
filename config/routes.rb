Rails.application.routes.draw do
  root 'home#index'

  get 'unsubscribe' => 'home#unsubscribe'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :destroy]
    end
  end

end
