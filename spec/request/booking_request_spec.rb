require "rails_helper"

class BooktTest < ActiveSupport::TestCase

  RSpec.describe "Bookings", type: :request do


    before(:each) do

      @attr_flight = {
        origin: "scl",
        destiny: "syd",
        date: "2022-07-10",
        time: "00:30"
      }

      @flight = Flight.create!(@attr_flight)

      # @seat1 = @flight.seats.new(row:1, column:"A", disponibility:true)
      # @seat2 = @flight.seats.new(row:2, column:"A", disponibility:true)
      # @seat3 = @flight.seats.new(row:3, column:"A", disponibility:true)
      # @seat4 = @flight.seats.new(row:4, column:"A", disponibility:false)
      # @seat5 = @flight.seats.new(row:5, column:"A", disponibility:false)
      # @seat1.save
      # @seat2.save
      # @seat3.save
      # @seat4.save
      # @seat5.save

      @attr_valid = {
        flight: @flight.id,
        user: "Tomas",
        seats: ["1A","2A"]
      }

      # @attr_invalid = {
      #   flight: -1,
      #   user: 2,
      #   seats: [1A2A]
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
          get "/bookings/new", params: { seats: "1A;2A",  user: "Tomas", flight: @flight.id }
          expect(response).to have_http_status(:ok)
      end
    end


    describe "create" do
      describe "si hay usuario" do
        @attr_flight = {
          origin: "scl",
          destiny: "syd",
          date: "2022-07-10",
          time: "00:30"
        }
        @flight3 = Flight.create!(@attr_flight)
        @seat9 = @flight3.seats.new(row:1, column:"A", disponibility:true)
        @seat10 = @flight3.seats.new(row:2, column:"A", disponibility:true)
        @seat9.save
        @seat10.save
        id_viaje = @flight3.id
        it "deberia crearse un booking con atributos validos" do
          expect do
            post "/bookings", params: { seats: "1A;2A", user: "Andres", flight_id: id_viaje }
          end.to change(Booking, :count).by(1)   
        end

        # it "no deberia crear un booking con atributos invalidos" do
        #   expect do
        #     post "/bookings", params: { seats: "1A2A3A", flight: id_viaje }
        #   end.to change(Booking, :count).by(0)
        # end
      end

    end

    describe "update" do
      describe "si hay usuario" do
        @attr_flight = {
          origin: "scl",
          destiny: "syd",
          date: "2022-07-10",
          time: "00:30"
        }

        @flight2 = Flight.create!(@attr_flight)
        @seat6 = @flight2.seats.new(row:1, column:"A", disponibility:true)
        @seat7 = @flight2.seats.new(row:2, column:"A", disponibility:true)
        @seat8 = @flight2.seats.new(row:3, column:"A", disponibility:true)
        @seat6.save
        @seat7.save
        @seat8.save
        @booking2 = Booking.create!(user: "Felipe", seats: ["1A","2A"], flight: @flight2.id)
        id_book = @booking2.id
        it "deberia crearse un booking con atributos validos" do
          patch "/bookings/#{id_book}", params: { booking: {seats: "3A"} }
          expect(response).to have_http_status(:found)
        end

        # it "no deberia crear un booking con atributos invalidos" do
        #   expect do
        #     post "/bookings", params: { seats: "1A2A3A", flight_id: @flight.id }
        #   end.to change(Booking, :count).by(0)
        # end
      end

    end

  end
end