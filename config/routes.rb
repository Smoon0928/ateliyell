Rails.application.routes.draw do
  namespace :admin do
    get 'genres/index'
    get 'genres/create'
    get 'genres/edit'
    get 'genres/update'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'products/index'
    get 'products/new'
    get 'products/create'
    get 'products/update'
    get 'products/show'
    get 'products/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/unsubscribe'
    get 'users/withdraw'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  get 'genres/index'
  get 'genres/create'
  get 'genres/edit'
  get 'genres/update'
  get 'products/index'
  get 'products/new'
  get 'products/create'
  get 'products/update'
  get 'products/show'
  get 'products/edit'
  get 'users/show'
  get 'users/edit'
  get 'users/update'
  get 'users/unsubscribe'
  get 'users/withdraw'
  get 'homes/top'
  get 'homes/about'
  

# user用
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# admin用
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
