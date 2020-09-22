Rails.application.routes.draw do

  root 'event#index'

  resources :events do
    member do
      get :delete
    end
  end

  get 'event/delete'
  get 'event/edit'
  get 'event/index'
  get 'event/new'
  get 'event/show'
  get 'event/homepage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
