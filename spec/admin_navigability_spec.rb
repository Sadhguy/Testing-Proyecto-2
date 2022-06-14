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

      for i in 0..24
        asiento1 = @flight_2.seats.new(row:i, column:"A", disponibility:true)
        asiento1.save
        asiento2 = @flight_2.seats.new(row:i, column:"B", disponibility:true)
        asiento2.save
        asiento3 = @flight_2.seats.new(row:i, column:"C", disponibility:true)
        asiento3.save
        asiento4 = @flight_2.seats.new(row:i, column:"D", disponibility:true)
        asiento4.save
        asiento5 = @flight_2.seats.new(row:i, column:"E", disponibility:true)
        asiento5.save
      end

      @booking = Booking.create!(user: "Pedro", seats: ["1A","2A","3A","4A","5A","6A","7A","8A","9A","10A"], flight: @flight_1.id)

      ["1A","2A","3A","4A","5A","6A","7A","8A","9A","10A"].each do |seat|
        seat1 = Seat.find_by(flight: @flight_1.id, row: seat[0..seat.length - 2], column: seat[seat.length - 1])
        seat1 = Seat.update(seat1.id, disponibility: false)
      end

      visit new_flight_path
      expect(page).to have_content('New flight')
      expect(page).to have_content('Origen')
      expect(page).to have_content('Destino')
      expect(page).to have_content('Fecha')
      expect(page).to have_content('Hora')
      expect(page).to have_current_path(new_flight_path)

      
      visit admin_flight_path(@flight_1.id)
      expect(page).to have_content('Origen: Santiago')
      expect(page).to have_content('Destino: Madrid')
      expect(page).to have_content('Fecha: 2023-01-01')
      expect(page).to have_content('Hora: 12:00PM')
      expect(page).to have_content('Reserva')
      expect(page).to have_content('Si quieres elegir más de un asiento debes separarlos con punto y coma (";") (Ej: 1A;2A;14B)')
      expect(page).to have_content('Destroy')
      expect(page).to have_current_path(admin_flight_path(@flight_1.id))

      visit flight_statistics_path
      expect(page).to have_content('Cantidad de vuelos: 2')
      expect(page).to have_content('Salidos: 0 (0.0%')
      expect(page).to have_content('Esperando: 2 (100.0%)')
      expect(page).to have_content('Ocupación promedio 4.0%')
      expect(page).to have_content('N° de vuelo: 1 Ocupación: 8.0%')
      expect(page).to have_content('N° de vuelo: 2 Ocupación: 0.0%')
      expect(page).to have_current_path(flight_statistics_path)

      visit bookings_path
      expect(page).to have_content('Bookings')
      expect(page).to have_content('Nombre')
      expect(page).to have_current_path(bookings_path)

      visit edit_booking_path(@booking.id)
      expect(page).to have_content('Usuario: Pedro')
      expect(page).to have_content('Asientos: ["1A", "2A", "3A", "4A", "5A", "6A", "7A", "8A", "9A", "10A"]')
      expect(page).to have_content('Asientos')
      expect(page).to have_content('Tienes que seleccionar nuevamente todos los asientos y separarlos con punto y coma (";") (Ej: 1A;2A;14B)')
      expect(page).to have_content('Destroy')
      expect(page).to have_current_path(edit_booking_path(@booking.id))
    end
  end
end

