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

      
      @attr_valid = {
        origin: "scl",
        destiny: "mia",
        date: "2022-09-10",
        time: "22:00"
      }

      @attr_invalid = {
        origin: 1,
        destiny: 1,
        date: 1,
        time: 1
      }

    end

    describe "index" do 
      it "should return a successful request" do 
          get "/flights"
          expect(response).to have_http_status(:ok)
      end
    end

    describe "show" do 
      it "should return a successful request" do 
          get "/flights/#{@flight.id}"
          expect(response).to have_http_status(:ok)
      end
    end

    describe "new" do 
      it "should return a successful request" do 
          get "/flights/new", params: { flight: @attr_valid }
          expect(response).to have_http_status(:ok)
      end
    end


    describe "create" do
      it "deberia crearse un vuelo con atributos validos" do
        expect do
          post "/flights", params: { flight: @attr_valid }
        end.to change(Flight, :count).by(1)   
      end

      it "no deberia crear un vuelo con atributos invalidos" do
        expect do
          post "/flights", params: { flight: @attr_invalid }
        end.to change(Flight, :count).by(0)
      end
    end


    describe "destroy" do
      it "deberia destruirse el vuelo correspondiente" do
        @flight2 = Flight.create!(@attr_valid)
        expect do
          delete "/flights/#{@flight.id}"
        end.to change(Flight, :count).by(-1)   
      end
    end
  end
end