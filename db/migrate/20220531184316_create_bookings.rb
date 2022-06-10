class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.string :user
      t.text :seats

      t.timestamps
    end
  end
end
