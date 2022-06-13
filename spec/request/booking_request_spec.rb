require "rails_helper"

class FlightTest < ActiveSupport::TestCase

  RSpec.describe "Flights", type: :request do


    before(:each) do

      @attr_flight = {
        origin: "scl",
        destiny: "syd",
        date: "2022-07-10",
        time: "00:30"
      }

      @flight = Flight.create!(@attr_flight)

      
      # @attr_valid = {
      #   flight_id: @flight.id,
      #   user: "Tomas",
      #   seats: "1A;2A"
      # }

      # @attr_invalid = {
      #   flight_id: -1,
      #   user: 2,
      #   seats: "1A2A"
      # }

    end

    describe "index" do 
      it "should return a successful request" do 
          get "/bookings"
          expect(response).to have_http_status(:ok)
      end
    end


    describe "new" do 
      it "should return a successful request" do 
          get "/bookings/new", params: { seats: "1A;2A",  user: "Tomas", flight_id: @flight_id }
          expect(response).to have_http_status(:ok)
      end
    end


    describe "create" do
      describe "si hay usuario" do
        it "deberia crearse un booking con atributos validos" do
          expect do
            post "/bookings", params: { seats: "1A;2A", user: "Andres", flight_id: @flight.id }
          end.to change(Booking, :count).by(1)   
        end

        it "no deberia crear un booking con atributos invalidos" do
          expect do
            post "/bookings", params: { seats: "1A2A3A", flight_id: @flight.id }
          end.to change(Booking, :count).by(0)
        end
      end

      describe "si no hay usuario" do
        it "no deberia crearse un booking con atributos validos pero sin usuario" do
          expect do
            post "/bookings", params: { seats: "1A;2A", flight_id: @flight.id }
          end.to change(Booking, :count).by(0)   
        end
      end

    end

  end
end