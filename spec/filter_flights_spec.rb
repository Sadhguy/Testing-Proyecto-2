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
      @flight = Flight.create!(@attr_flight1)
      @attr_flight2 = {
        origin: "Lima",
        destiny: "Madrid",
        date: "2023-01-01",
        time: "12:00"
        }
      @flight = Flight.create!(@attr_flight2)

      visit root_path
      expect(page).to have_content('Flights')
      fill_in 'Origin', with: 'Santiago'
      fill_in 'Destiny', with: 'Madrid'
      fill_in 'Date', with: '01-01-2023'
      fill_in 'Time', with: '12:00'
      click_button 'Buscar'
      expect(page).to have_content('Vuelo Santiago-Madrid 2023-01-01 12:00PM')
    end
  end
end