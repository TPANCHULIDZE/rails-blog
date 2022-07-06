Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :posts do
      resources :comments, only: %i[create update destroy]
      resources :likes, only: %i[create destroy new]
    end

    get "user/:id/posts", to: "posts#user_posts", as: :user_post

    devise_for :users, controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      passwords: 'users/passwords'
    }
    post "users/status/guest/:id", to: 'user_status#user_become_guest', as: :become_guest
    post "users/status/member/:id", to: 'user_status#user_become_member', as: :become_member
    post "users/status/admin/:id", to: 'user_status#user_become_admin', as: :become_admin
    
    get "users/:id/profile", to: 'profile#profile', as: :profile

    get "/unapprove_posts", to: "posts#unapprove_posts", as: :unapprove_posts
    post "/approve_post/:id", to: "posts#approve_post", as: :approve_post

    root to: "home#index"
  end
end
