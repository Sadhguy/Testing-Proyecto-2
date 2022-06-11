class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    seats = params[:seats].split(";")
    if seats.length > 0 && seats[0].length < 4 && params[:user] != ''
      for seat in seats do
        seat = Seat.find_by(flight: params[:flight_id], row: seat[0..seat.length - 2], column: seat[seat.length - 1])
        if seat
          seat = Seat.update(seat.id, disponibility: false)
        end
      end
      booking = Booking.new(user: params[:user], seats: seats)
    end

    #puts(@booking.seats)
    
    #if @booking.save
    #  redirect_to @booking
    #else
    #  render :new, status: :unprocessable_entity
    #end
    redirect_to "/flights/#{params[:flight_id]}"
  end
end
