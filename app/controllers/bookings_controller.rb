class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(user: params[:user], seats: params[:seats])

    puts(@booking.seats)
    
    if @booking.save
      redirect_to @booking
    else
      render :new, status: :unprocessable_entity
    end
  end
end
