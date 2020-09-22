Rails.application.routes.draw do

  root 'events#index'

  resources :events do
    member do
      get :delete
    end
  end

  get 'events/delete'
  get 'events/edit'
  get 'events/index'
  get 'events/new'
  get 'events/show'
  get 'events/homepage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
