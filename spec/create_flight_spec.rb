require 'rails_helper'

RSpec.describe 'Create Flights', type: :system do
  describe 'index page' do
    it 'shows the right content' do

      visit new_flight_path
      expect(page).to have_content('New flight')
      fill_in 'flight[origin]', with: 'Santiago'
      fill_in 'flight[destiny]', with: 'Madrid'
      fill_in 'flight[date]', with: '01-01-2023'
      fill_in 'flight[time]', with: '12:00'
      click_button 'Create Flight'
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