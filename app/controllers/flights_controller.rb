class FlightsController < ApplicationController
  def index
    @flights = Flight.where("destiny like :destiny and origin like :origin and date::text like :date and time::text like :time", destiny: "%#{params[:destiny]}%", origin: "%#{params[:origin]}%", date: "%#{params[:date]}%", time: "%#{params[:time]}%")
  end
  helper_method :index

  def show
    @flight = Flight.find(params[:id])
  end
  helper_method :show
  
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


  def ocupation(id)
    puts id
    @flight = Flight.find(id)
    @taken = 0
    @seats = @flight.seats.count
    for seat in @flight.seats
      if !seat.disponibility
        @taken += 1
      end
    end
    @ocupation = @taken.to_f / @seats
    return @ocupation
  end
  helper_method :ocupation

  def statistics
    @all = Flight.count
    @past = Flight.where("date < :datenow", datenow: Date.today).count
    @future = Flight.where("date > :datenow", datenow: Date.today).count
    @taken = 0
    @all_seats = 0
    @flights = Flight.all
    @static_taken = 0
    for flight in @flights
      for seat in flight.seats
        if !seat.disponibility
          @taken += 1
        end
        @all_seats += 1
      end
      @static_taken += ocupation(flight.id)
    end
    @static_taken = @static_taken/@all 
  end

  private
    def flight_params
      params.require(:flight).permit(:origin, :destiny, :date, :time)
    end

end
