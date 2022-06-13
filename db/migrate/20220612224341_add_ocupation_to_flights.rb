class AddOcupationToFlights < ActiveRecord::Migration[7.0]
  def change
    add_column :flights, :ocupation, :float
  end
end
