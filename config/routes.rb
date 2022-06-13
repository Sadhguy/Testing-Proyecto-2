Rails.application.routes.draw do
  root "flights#index"

  get '/flights/admin', to: 'flights#admin', :as => 'admin_flights'
  get '/flights/:id/admin', to: 'flights#adminflight', :as => 'admin_flight'
  get '/flights/statistics', to: 'flights#statistics', :as => 'flight_statistics'
  resources :flights
  post 'bookings/create', :to => 'bookings#create', :as => 'create_booking'
  resources :bookings
end
