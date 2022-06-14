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

    end

    describe "index" do 
      it "should return a successful request" do 
          get "/bookings"
          expect(response).to have_http_status(:ok)
      end
    end

    describe "edit" do 
      it "should return a successful request" do 
        attr_flight = {
        origin: "scl",
        destiny: "syd",
        date: "2022-07-10",
        time: "00:30"
        }
        @flight5 = Flight.create!(@attr_flight)
        @seat11 = @flight5.seats.new(row:1, column:"A", disponibility:true)
        @seat12 = @flight5.seats.new(row:2, column:"A", disponibility:true)
        @seat11.save
        @seat12.save
        @booking4 = Booking.create!(user: "Felipe", seats: ["1A","2A"], flight: @flight5.id)
        id_book = @booking4.id
          get "/bookings/#{id_book}/edit"
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
      end

      # describe "si no hay usuario" do
      #   @attr_flight = {
      #     origin: "scl",
      #     destiny: "syd",
      #     date: "2022-07-10",
      #     time: "00:30"
      #   }
      #   @flight3 = Flight.create!(@attr_flight)
      #   @seat9 = @flight3.seats.new(row:1, column:"A", disponibility:true)
      #   @seat10 = @flight3.seats.new(row:2, column:"A", disponibility:true)
      #   @seat9.save
      #   @seat10.save
      #   id_viaje = @flight3.id
      #   it "deberia crearse un booking con atributos validos" do
      #     expect do
      #       post "/bookings", params: { seats: "1A;2A", flight_id: id_viaje }
      #     end.to change(Booking, :count).by(0)   
      #   end
      # end

    end

    
    describe "update" do
        it "deberia editarse un booking con atributos validos" do
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
          patch "/bookings/#{id_book}", params: { booking: {seats: "3A"} }
          expect(response).to have_http_status(:found)
        end
    end

    # describe "update" do 
    #   it "should return a successful request" do 
    #     attr_flight = {
    #     origin: "scl",
    #     destiny: "syd",
    #     date: "2022-07-10",
    #     time: "00:30"
    #     }
    #     @flight7 = Flight.create!(@attr_flight)
    #     @seat6 = @flight7.seats.new(row:1, column:"A", disponibility:true)
    #     @seat7 = @flight5.seats.new(row:2, column:"A", disponibility:true)
    #     @seat8 = @flight5.seats.new(row:3, column:"A", disponibility:true)
    #     @seat6.save
    #     @seat7.save
    #     @seat8.save
    #     @booking7 = Booking.create!(user: "Felipe", seats: ["1A","2A"], flight: @flight7.id)
    #     id_book = @booking7.id
    #       patch "/bookings/#{id_book}" params: { booking: {seats: "3A"} }
    #       expect(response).to have_http_status(:ok)
    #   end
    # end

    describe "destroy" do
      it "deberia destruirse el booking correspondiente" do
        @attr_flight = {
          origin: "scl",
          destiny: "syd",
          date: "2022-07-10",
          time: "00:30"
        }
        @flight4 = Flight.create!(@attr_flight)
        @booking3 = Booking.create!(user: "Felipe", seats: ["1A","2A"], flight: @flight4.id)
        #id_booking_3 = @booking3.id
        expect do
          delete "/bookings/#{@booking3.id}"
        end.to change(Booking, :count).by(-1)   
      end
    end

  end
end