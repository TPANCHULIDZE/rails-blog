Rails.application.routes.draw do
  require 'sidekiq/web'
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :posts do
      resources :comments, only: %i[create update destroy]
      resources :likes, only: %i[create destroy]
    end

    authenticate :user, ->(user) { user.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end

    get "user/:id/posts", to: "posts#user_posts", as: :user_post

    devise_for :users, skip: :omniauth_callbacks, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }

    get "users/:user_id/charges/new", to: "charges#new", as: :new_charges
    post "users/:user_id/charges/create", to: "charges#create", as: :charges

    get "users/mobile_phone", to: "mobiles#new"
    post "users/mobile_phone", to: "mobiles#create"
    delete "users/:user_id/mobile_phone/delete/:id", to: "mobiles#destroy", as: :destroy_mobile

    post "users/status/guest/:id", to: 'user_status#user_become_guest', as: :become_guest
    post "users/status/member/:id", to: 'user_status#user_become_member', as: :become_member
    post "users/status/admin/:id", to: 'user_status#user_become_admin', as: :become_admin
    
    get "users/:id/profile", to: 'profile#profile', as: :profile

    get "/users/:user_id/unapprove_posts", to: "posts#unapprove_posts", as: :unapprove_posts
    post "users/:user_id/approve_post/:id", to: "posts#approve_post", as: :approve_post

    get "/users/:user_id/locations/all", to: "locations#index", as: :locations
    get "/users/locations/show/:id", to: "locations#show", as: :show_location
    get "users/locations/add", to: "locations#new", as: :add_location
    post "users/locations/add", to: "locations#create", as: :create_location
    delete "users/:user_id/locations/delete/:id", to: "locations#destroy", as: :destroy_address
   
    root to: "home#index"
  end

  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
