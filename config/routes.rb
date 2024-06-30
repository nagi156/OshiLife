Rails.application.routes.draw do
  # 顧客のルーティング↓
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }
  # ゲストログインのルーティング
  devise_scope :user do
    post "users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end
  scope module: :public do
    root to: "homes#top"
    get "search" => "searches#search"
    get "/about" => "homes#about", as: "about"
    get '/privacy' => "homes#privacy", as: "privacy"
    get '/terms_of_service' => "homes#terms_of_service", as: "terms_of_service"
    get "/my_page", to: "users#my_page", as: "my_page"
    get '/users/:id', to: 'users#show', as: 'user'
    resources :users, except: [:new, :show,:destroy] do
      member do
        get :likes
      end
      resource :relationship, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end
    # 退会確認用のルーティング
    get '/users/:id/unsubscribe' => 'users#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'
    resources :posts do
      resource :favorite, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
    resources :chats, only: [:show, :create, :destroy]
    resources :notifications, only: [:index, :destroy]
    resources :genres, only: [:index,:show]
    resources :inquiries, only: [:new, :create, :index, :show]
  end

  #ここから管理者のルーティング↓
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get '' => "homes#top"
    resources :genres, except: [:new]
    resources :posts, only: [:show, :destroy]
    resources :users, except: [:new, :destroy]
    resources :comments, only: [:destroy]
    resources :inquiries, only: [:index, :show] do
      member do
        patch 'respond'
        get "send_mail"
      end
    end
    get "search" => "searches#search"
  end

  get '/favicon.ico', to: proc { [204, {}, []] }
end
