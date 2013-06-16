PhaseOne::Application.routes.draw do

  resources :committee_emails


  resources :visitor_mail_subjects


  resources :visitor_mails


  resources :events


  resources :event_types


  resources :items


  resources :item_types


  resources :uoms

  match "admins/dashboard" => "dashboards#index", :via => :get

  devise_for( :admins, :class_name => 'Admin', :controllers => {:registrations => "registrations"})
  
  devise_scope :admin do
    match "admins/signup_landing"  =>  "registrations#signup_landing", :via  =>  :get 
  end
 
  resources :notifications
  match "current_notifications" => "static_pages#notifications"

  match "activities" => "static_pages#activities"

  match "current_events" => "static_pages#events"

  match "about_us" => "static_pages#about_us"

  match "contact" => "static_pages#contact"

  match "credits" => "static_pages#credits"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => "static_pages#home"
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
