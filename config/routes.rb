Rails.application.routes.draw do
  # devise_for :users
  # namespace :api, defaults: { format: :json } do
  # post 'auth_user' => 'users/authentication#authenticate_user'
  get 'users/:user_id/files/:id', to: "users/files#download"
  # devise_scope :user do
  #   get "users/sign_in" => "users/sessions#new"
  #   post "users/sign_in" => "users/sessions#create"  #working
  #   delete "users/sign_out" => "users/sessions#destroy"
  #   delete "users/" => "users/registrations#destroy"  #not working, undefined method `protect_against_forgery in sessions new
  #   post "users/sign_up" => "users/registrations#create"  #working
  #   get "users/:id" => "users/registrations#show"  #working
  # end
  # end
  # redefine routes for sign_in -> login, sign_out -> logout, registration -> signup
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}

  delete "users/:user_id/files/:id" => "users/files#destroy" #delete files, working
  post "users/:user_id/files" => "users/files#create" #upload files, working
  get "users/:user_id/files" => "users/files#index"  #show all uploaded files with blob-id, working

  # devise_for :users, :controllers => {:registrations => "users/registrations",
                                      # :sessions => "users/sessions"}

  # resources :users do
  #   collection do
  #     resource :registrations
  #    end
  # end
end
