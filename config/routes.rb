Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'

  get 'registrations/edit' => 'home#edit'

  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        collection do
          delete 'delete', to: 'users#destroy_with_contact_info'
        end
      end
    end
  end

end
