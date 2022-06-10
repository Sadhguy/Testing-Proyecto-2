class FlightsController < ApplicationController
  def index
    @flights = Flight.all
  end

  def show
    @flight = Flight.find(params[:id])
  end

  def new
    @flight = Flight.new
  end

  def create
    @flight = Flight.new(flight_params)

    ('A'...'F').each do |col|
      (1...24).each do |fil|
        @seat = @flight.seats.new(row:fil, column:col, disponibility:true)
        @seat.save
      end
    end

    if @flight.save
      redirect_to @flight
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @flight = Flight.find(params[:id])
    @flight.destroy

    redirect_to root_path, status: :see_other
  end
  private
    def flight_params
      params.require(:flight).permit(:origin, :destiny, :date, :time)
    end

end
