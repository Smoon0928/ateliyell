Rails.application.routes.draw do
  
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
    resources :users,only:[:index,:show,:edit,:update,:unsubscribe,:withdraw]
  end

  

  scope module: :public do
   
    resources :products,only:[:index,:new,:create,:update,:show,:edit,:destroy]do
    resources :comments, only: [:create]
   end
    resources :users,only:[:index,:show,:edit,:update,:unsubscribe,:withdraw]
    
  end
 


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

