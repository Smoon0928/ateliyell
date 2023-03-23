Rails.application.routes.draw do
  
  namespace :public do
    get 'friends/followings'
    get 'friends/followers'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  # admin用
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
  }
  
  # user用
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }
  
  root to: "public/homes#top"
  get 'about'=>"public/homes#about",as: "about"
    
  namespace :admin do
    root to: 'homes#top'
    resources :genres,only:[:index,:create,:edit,:update]
    resources :products,only:[:index,:update,:show,:edit,:destroy]
    resources :users,only:[:index,:show,:edit,:update,:destroy]
    get "users/unsubscribe/:id" => "users#unsubscribe", as:"admin/unsubscribe"
  end

  

  scope module: :public do
   
    resources :products,only:[:index,:new,:create,:update,:show,:edit,:destroy]do
      resource :likes, only: [:create, :destroy, :show]
      resources :comments, only: [:create, :destroy]
    end
    post 'products/upload_image' => 'products#upload_image'
    resources :users,only:[:index,:show,:edit,:update,:destroy]do
      
       member do
        get :followings, :followers
        get "users/unsubscribe/:id" => "users#unsubscribe", as:"unsubscribe"
        get :likes
        get "products/private" => "products#private",as:"private"
      end
      collection do
        get 'search'
      end
    end
    resources :friends, except: [:create, :destroy]do
      member do
        get :followings, :followers
      end
    end
    post 'friends/:user_id' => 'friends#create', as:'follow'
    delete 'friends/:user_id' => 'friends#destroy', as:'unfollow'
    get 'followings' => 'friends#followings', as: 'followings'
    get 'followers' => 'friends#followers', as: 'followers'
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
 


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

