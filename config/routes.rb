Rails.application.routes.draw do
  resources :blogs do
    collection do
      post :confirm
      get :top
    end
  end
end
