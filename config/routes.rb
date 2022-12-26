Rails.application.routes.draw do
  get 'users/new'
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'
  # get 'homes/top'
  root to: 'homes#top'
  get "/home/about" => "homes#about", as: "about"
  devise_for :users

  resources :books, only: [:new, :create, :index, :show, :edit, :destroy, :update]
  resources :users, only: [:new, :create, :index, :show, :edit, :destroy, :update]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
