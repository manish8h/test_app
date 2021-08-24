Rails.application.routes.draw do
  resources :comments

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'welcome#home'
  get 'welcome/home', to: 'welcome#home'
  get 'welcome/about', to: 'welcome#about'
  #article
  resources :articles
  resources :blogs
end
