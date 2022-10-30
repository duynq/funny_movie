Rails.application.routes.draw do
  resources :users do
    collection do
      resource :sessions, only: %i[create destroy]
    end
  end

  resources :movies, only: %i[index create new]
  root "movies#index"
end
