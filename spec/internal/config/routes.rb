Rails.application.routes.draw do
  resources :dummies do
    collection do
      get :test
    end
  end
end
