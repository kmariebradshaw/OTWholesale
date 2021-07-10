Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
    resources :customers
  end
  get 'welcome/index'
  root to: redirect('/users/sign_in')
  resources :customers, only: [:new]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
