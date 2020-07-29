Rails.application.routes.draw do
  get 'welcome/index'
  
  get 'about', to: 'about#index'
  get 'contact', to: 'contact#index'
  
  resources :articles do
    resources :comments
  end

  get 'signup', to: 'users#new'
  resources :users, except: [:new]
  
  root 'welcome#index'
end
