Rails.application.routes.draw do
  root "flights#index"

  get '/flights/statistics', to: 'flights#statistics', :as => 'flight_statistics'
  resources :flights
  post 'bookings/create', :to => 'bookings#create', :as => 'create_booking'
  resources :bookings
end
