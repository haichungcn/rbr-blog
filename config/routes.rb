Rails.application.routes.draw do
  get 'welcome/index'
  
  get 'about', to: 'about#index'
  get 'contact', to: 'contact#index'
  
  resources :articles do
    resources :comments
  end

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # handle session
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :categories, except: [:destroy]

  root 'welcome#index';
end
