Rails.application.routes.draw do
  # エンドユーザー用
  devise_for :end_users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root :to => "homes#top"
    get "about" => "homes#about"
    get "end_users/withdraw_confirm" => "end_users#withdraw_confirm", as: "withdraw_confirm"
    patch "end_users/withdraw" => "end_users#withdraw"
    resources :end_users, only: [:show, :edit, :update]
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
   resources :posts, only: [:index, :show, :destroy] do
     resources :comments, only: [:destroy]
   end
   resources :end_users, only: [:show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
