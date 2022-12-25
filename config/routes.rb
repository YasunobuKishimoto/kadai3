Rails.application.routes.draw do
  get 'users/new'
  # get 'books/index'
  # get 'books/show'
  # get 'books/edit'
  # get 'homes/top'
  root to: 'homes#top'
  devise_for :users

  resources :books, only: [:new, :create, :index, :show, :edit, :destroy, :update]
  resources :users, only: [:new, :create, :index, :show, :edit, :destroy, :update]

  get "/homes/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
