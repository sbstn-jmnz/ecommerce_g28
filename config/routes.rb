Rails.application.routes.draw do

  resources :products, only: :index do
    resources :orders, only: :create
  end

  resources :orders, only: :index do
  	collection do
  		get 'clean'
  	end
  end

  get 'billings/pre_pay', to: 'billings#pre_pay', as: 'pre_pay_billings'
  get 'billings/execute', to: 'billings#execute', as: 'execute_billings'

  devise_for :users

  root 'products#index'

end
