Rails.application.routes.draw do
  
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
  end
  

  scope module: :public do
   
    resources :products,only:[:index,:new,:create,:update,:show,:edit]
    resources :users,only:[:show,:edit,:update,:unsubscribe,:withdraw]
  
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

