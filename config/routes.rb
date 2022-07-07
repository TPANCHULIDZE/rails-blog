Rails.application.routes.draw do
  require 'sidekiq/web'
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :posts do
      resources :comments, only: %i[create update destroy]
      resources :likes, only: %i[create destroy new]
    end

    authenticate :user, ->(user) { user.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end

    get "user/:id/posts", to: "posts#user_posts", as: :user_post

    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }

    get "users/mobile_phone", to: "mobiles#new"
    post "users/mobile_phone", to: "mobiles#create"
    delete "users/mobile_phone/delete/:id", to: "mobiles#destroy", as: :destroy_mobile

    post "users/status/guest/:id", to: 'user_status#user_become_guest', as: :become_guest
    post "users/status/member/:id", to: 'user_status#user_become_member', as: :become_member
    post "users/status/admin/:id", to: 'user_status#user_become_admin', as: :become_admin
    
    get "users/:id/profile", to: 'profile#profile', as: :profile

    get "/unapprove_posts", to: "posts#unapprove_posts", as: :unapprove_posts
    post "/approve_post/:id", to: "posts#approve_post", as: :approve_post

    root to: "home#index"
  end
end
