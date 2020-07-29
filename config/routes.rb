Rails.application.routes.draw do
  get 'welcome/index'
  
  get 'about', to: 'about#index'
  get 'contact', to: 'contact#index'
  
  resources :articles do
    resources :comments
  end

  root 'welcome#index'
end
