Rails.application.routes.draw do
  get "clienttest", to: "records#index"

  post "read", to: "records#read"

  post "create", to: "records#create"

  post "test", to: "records#test"

  #records cannot be updated as per requirements
  #post "update", to: "records#update"

  post "delete", to: "records#delete"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
