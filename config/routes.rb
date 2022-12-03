Rails.application.routes.draw do

  resources :instructors, only:[:index, :create, :show, :destroy, :update]
  resources :students, only:[:index, :create, :show, :destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
