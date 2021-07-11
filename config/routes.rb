Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root to: 'welcome#index', as: :authenticated_root
    resources :customers
    resources :welcome
  end

  resources :users
  resources :customers
  resources :welcome
  root to: redirect('/users/sign_in')


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
