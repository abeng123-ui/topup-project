Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  post 'users/create' => 'users#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
