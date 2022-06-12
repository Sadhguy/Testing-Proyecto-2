class AddFlightToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :flight, :integer
  end
end
