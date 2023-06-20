Rails.application.routes.draw do
  # エンドユーザー用
  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_scope :end_user do
    post "end_users/guest_sign_in", to: "public/sessions#guest_sign_in"
  end

  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    get "search" => "homes#search"
    get "ranking" => "cats#ranking"
    get "end_users/withdraw_confirm" => "end_users#withdraw_confirm", as: "withdraw_confirm"
    patch "end_users/withdraw" => "end_users#withdraw"
    resources :end_users, only: [:show, :edit, :update] do
      get "bookmark_cats" => "end_users#bookmark_cats"
    end
    resources :cats, only: [:new, :create, :show, :edit, :update] do
      resource :bookmarks, only: [:create, :destroy]
    end
    resources :posts do
      resource :likes, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end

  # 管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
   get "/" => "homes#top"
   get "search" => "homes#search"
   resources :posts, only: [:index, :show, :destroy] do
     resources :comments, only: [:destroy]
   end
   resources :end_users, only: [:show, :edit, :update] do
     get "posts" => "end_users#posts_index", as: "posts_index"
   end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
