require "rails_helper"

class SeatTest < ActiveSupport::TestCase

  RSpec.describe "Seats", type: :request do


    before(:each) do

      @attr_flight = {
        origin: "scl",
        destiny: "syd",
        date: "2022-07-10",
        time: "00:30"
      }

      @flight = Flight.create!(@attr_flight)

      
      @attr_valid = {
        row: 7,
        column: "C",
        disponibility:true
      }

      @attr_invalid = {
        row: "seis",
        column: 6,
        disponibility:6
      }

    end


    # describe "new" do 
    #   it "should return a successful request" do 
    #       get "/seat/new", params: { seat: @attr_valid, flight_id: @flight.id }
    #       expect(response).to have_http_status(:ok)
    #   end
    # end


    # describe "create" do
    #   it "deberia crearse una clase con atributos validos" do
    #     expect do
    #     post "/seats", params: { seat: @attr_valid }
    #     end.to change(Seat, :count).by(1)   
    #   end

    #   it "no deberia crear una clase con atributos invalidos" do
    #     expect do
    #     post "/seats", params: { seat: @attr_invalid }
    #     end.to change(Seat, :count).by(0)
    #   end
    # end

    # describe "create" do
    #   it "deberia crearse un vuelo con atributos validos" do
    #     expect do
    #       post "/flights", params: { flight: @attr_flight }
    #     end.to change(Seat, :count).by(115)   
    #   end
    # end

  end
end