Rails.application.routes.draw do
  # devise_for :users
  # namespace :api, defaults: { format: :json } do
  devise_scope :user do
    post "users/registrations" => "users/registrations#create"  #working
    # delete "users/:id" => "users/registrations#destroy"  #not working
    get "users/:id" => "users/registrations#show"  #working
    get "users/sign_in" => "users/sessions#new"
    post "users/login" => "users/sessions#create"  #working
    delete "users/sign_out" => "users/sessions#destroy"
  end
  # end
  delete "users/:user_id/avatar/:id" => "users/avatars#destroy" #delete files, working
  post "users/:user_id/avatar" => "users/avatars#create" #upload files, working
  get "users/:user_id/avatar" => "users/avatars#show"  #show all uploaded files with blob-id, working

  devise_for :users, :controllers => {:registrations => "users/registrations",
                                      :sessions => "users/sessions"}

  resources :users do
    collection do
      resource :registrations
     end
  end
end
