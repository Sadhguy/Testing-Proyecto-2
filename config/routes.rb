Rails.application.routes.draw do
  root "flights#index"

  resources :flights
  post 'bookings/create', :to => 'bookings#create', :as => 'create_booking'
  resources :bookings
end
