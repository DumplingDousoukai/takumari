Rails.application.routes.draw do

  get 'takumarequests/join' => "takumarequests#join"

  get "rooms/top"
  resources :rooms, only: [:top, :show, :create]

  mount ActionCable.server => '/cable'

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get 'posts/index' => "posts#index"
  get "posts/index2" => "posts#index2"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  get "users/:id/likes" => "users#likes"
  get "users/search" => "users#search"

  get '/' => "home#top"

  devise_for :users, controllers: {
  sessions: 'devise/sessions',
  registrations: 'devise/registrations'
  }
  devise_scope :user do
   get "sign_in", :to => "devise/sessions#new"
   get "sign_out", :to => "devise/sessions#destroy"
  end
  get 'users/index'
  root "users#index"
  resources :users, only: :show

  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
