Rails.application.routes.draw do
  # users
  root "users#index"
  post "/users/new" => "users#create"
  post "/users/login" => "users#login"
  get "/users/logout" => "users#logout"

  # groups
  get "/groups" => "groups#index"
  post "/groups/new" => "groups#create"
  get "/groups/:g_id" => "groups#show"

  patch "/groups/:g_id" => "groups#join"
  delete "/groups/:g_id" => "groups#leave"
end
