Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/admin", to: "admin#index"

  namespace :admin do
    resources :merchants
    resources :invoices, only: [:index, :show, :update]
  end

  resources :merchants do
    get "/dashboard", to: "merchants#dashboard"
    scope module: 'merchant' do
      resources :items
      resources :invoices
      resources :bulk_discounts
    end
  end
end
