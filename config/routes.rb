Rails.application.routes.draw do
  resources :package_architectures

  resources :package_versions

  resources :releases

  resources :packages

  resources :db_package_types

  resources :roles

  devise_for :sessions, controllers: {sessions: "sessions"}, :path_names => { :sign_in => "login", :sign_out => "logout" }

  resources :warranty_types

  resources :warranty_contracts

  resources :vendors

  resources :support_groups

  resources :support_contacts

  resources :service_levels

  resources :server_apps

  resources :operating_systems

  resources :operation_statuses

  resources :operation_levels

  resources :oob_remote_mngmts

  resources :models

  resources :locations

  resources :impact_levels

  resources :impact_hours

  resources :hosts

  resources :escalation_levels

  resources :enterprise_applications

  resources :dr_shutdown_stages

  resources :dr_methods

  resources :db_servers

  resources :db_scheduled_jobs

  resources :db_repl_types

  resources :db_repl_statuses

  resources :db_replications

  resources :db_repl_freqs

  resources :db_packages

  resources :db_names

  resources :db_job_types

  resources :db_job_statuses

  resources :db_job_freqs

  resources :db_instances

  resources :db_clusters

  resources :cert_types

  resources :certs

  resources :backup_strategies

  resources :app_user_types

  resources :app_users

  resources :application_types

  resources :application_statuses

  resources :applications

  resources :ad_domains

  # default URL
  root :to => 'applications#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
