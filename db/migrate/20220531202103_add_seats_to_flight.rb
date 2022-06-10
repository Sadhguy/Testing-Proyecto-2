class AddSeatsToFlight < ActiveRecord::Migration[7.0]
  def change
    add_reference :seats, :flight
  end
end
