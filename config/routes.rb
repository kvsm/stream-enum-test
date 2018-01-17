Rails.application.routes.draw do
  resources :streaming_data, only: :index
end
