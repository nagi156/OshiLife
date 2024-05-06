Rails.application.routes.draw do
  # 顧客のルーティング↓
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  scope module: :public do
    root to: "homes#top"
    get "home/about" => "homes#about", as: "about"
    resources :users, param: :name, except: [:new, :destroy] do
      member do
        get :likes
      end
      get "users/unsubscribe" => "users#unsubscribe"
      get "users/withdraw" => "users#withdraw"
      resource :relationships, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :comment, only: [:create, :destroy]
    end
    resources :chats, only: [:show, :create, :destroy]
    get "search" => "searches#search"
  end

  #ここから管理者のルーティング↓
  scope module: :admin do
    get "/admin" => "homes#top"
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    resources :posts, except: [:new, :index]
    resources :users, except: [:new, :destroy]
    resources :comments, only: [:destroy]
    get "search" => "searches#search"
  end
end
