Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :carparks, only: [], defaults: {format: :json} do
    collection do
      get :nearest
    end
  end
end
