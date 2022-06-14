require 'rails_helper'

RSpec.describe 'Filter Flights', type: :system do
  describe 'index page' do
    it 'shows the right content' do
      @attr_flight1 = {
        origin: "Santiago",
        destiny: "Madrid",
        date: "2023-01-01",
        time: "12:00"
        }
      @flight_1 = Flight.create!(@attr_flight1)
      @attr_flight2 = {
        origin: "Lima",
        destiny: "Madrid",
        date: "2023-01-01",
        time: "12:00"
        }
      @flight_2 = Flight.create!(@attr_flight2)

      for i in 0..24
        asiento1 = @flight_1.seats.new(row:i, column:"A", disponibility:true)
        asiento1.save
        asiento2 = @flight_1.seats.new(row:i, column:"B", disponibility:true)
        asiento2.save
        asiento3 = @flight_1.seats.new(row:i, column:"C", disponibility:true)
        asiento3.save
        asiento4 = @flight_1.seats.new(row:i, column:"D", disponibility:true)
        asiento4.save
        asiento5 = @flight_1.seats.new(row:i, column:"E", disponibility:true)
        asiento5.save
      end

      
      visit root_path
      expect(page).to have_content('Flights')
      expect(page).to have_content('Origin')
      expect(page).to have_content('Destiny')
      expect(page).to have_content('Date')
      expect(page).to have_content('Time')
      expect(page).to have_content('Vuelo Santiago-Madrid 2023-01-01 12:00PM')
      expect(page).to have_content('Vuelo Lima-Madrid 2023-01-01 12:00PM')
      expect(page).to have_current_path(root_path)
      click_on 'Vuelo Santiago-Madrid 2023-01-01 12:00PM'
      sleep(1)

      expect(page).to have_current_path(flight_path(1))
      expect(page).to have_content('Origen: Santiago')
      expect(page).to have_content('Destino: Madrid')
      expect(page).to have_content('Fecha: 2023-01-01')
      expect(page).to have_content('Hora: 12:00PM')
      expect(page).to have_content('Reserva')
      expect(page).to have_content('Si quieres elegir más de un asiento debes separarlos con punto y coma (";") (Ej: 1A;2A;14B)')
      



    end
  end
end

