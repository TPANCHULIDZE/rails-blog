Rails.application.routes.draw do
  resources :posts do
    resources :comments
  end

  get "user/:id/posts", to: "posts#user_posts", as: :user_post

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get "users/:id/profile", to: 'profile#profile', as: :profile
  root to: "home#index"
end
