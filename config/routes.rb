Rails.application.routes.draw do

  resources :sessions, only: [:new, :create, :destroy]

  resources :users, only: [:new, :create, :show] do
    collection do
      post :confirm
    end
  end

  resources :blogs do
    collection do
      post :confirm
      get :top
    end
  end
  
  get '/top', to: 'tops#top'

end
