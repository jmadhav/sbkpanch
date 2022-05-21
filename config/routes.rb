Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "current_notifications" => "static_pages#notifications"

  get "activities" => "static_pages#activities"

  get "current_events" => "static_pages#events"

  get "about_us" => "static_pages#about_us"

  get "contact" => "static_pages#contact"

  get "credits" => "static_pages#credits"


  root :to => "static_pages#home" 
end
