Zoo::Application.routes.draw do
  resources :settings

  devise_for :users
    
  resources :users

  resources :quizzes

  resources :animals

  get "users/:id/assign_admin_role/" => 'users#assign_admin_role', as: :assign_admin_role
  get "users/:id/remove_admin_role/" => 'users#remove_admin_role', as: :remove_admin_role

  get ":controller/:action"
  
  scope "/pages" do
    get "quizzes/prepare_game" => 'quizzes#prepare_game', :defaults => { :format => 'json' }
  end

  
  root :to => 'pages#home'
  
 # unless Rails.application.config.consider_all_requests_local
  match '*not_found(.*)', to: 'errors#error_404', via: [:get, :post]
 # end


end
