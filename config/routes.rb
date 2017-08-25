Rails.application.routes.draw do

  resources :products, only: :index do
    resources :orders, only: :create
  end

  resources :orders, only: :index do
  	collection do
  		get 'clean'
  	end
  end

  devise_for :users

  root 'products#index'
  
end
