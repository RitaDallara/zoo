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

 

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
