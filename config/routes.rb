Surveysurvey::Application.routes.draw do |map|
  
  get "password_resets/new"
  
  resources :surveys
  map.connect '/respond', :controller => 'surveys', :action => 'respond'

  resources :users
  map.connect '/create-admin', :controller => 'users', :action => 'admin_create_user'
  
  resources :sessions, :only => [:new, :create, :destroy]
  resources :microposts, :only => [:create, :destroy]
  resources :password_resets
  
  match '/signup', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/contact', :to => 'pages#contact'
  match '/about', :to => 'pages#about'
  match '/help', :to => 'pages#help'
  match '/create-user', :to => 'users#create-user'
  
  root :to => "pages#home"
  
end