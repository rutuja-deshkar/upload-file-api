Rails.application.routes.draw do
  get 'users/:user_id/files/:id', to: 'users/files#download'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations'}

  delete 'users/:user_id/files/:id', to: 'users/files#destroy'
  post 'users/:user_id/files', to: 'users/files#create'
  get 'users/:user_id/files', to: 'users/files#index'
end
