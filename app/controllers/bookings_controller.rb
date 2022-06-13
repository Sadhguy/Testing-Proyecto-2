class BookingsController < ApplicationController
  def new
    @booking = Booking.new
  end

  def index
    @bookings = Booking.where("user like :user", user: "%#{params[:user]}%")
  end

  def edit
    @booking = Booking.find(params[:id])
  end

  def update
    new_seats = params[:booking][:seats].split(";")
    @booking = Booking.find(params[:id])
    old_seats = @booking.seats

    if @booking.update(seats: new_seats)
      for seat in old_seats do
        sit = Seat.find_by(flight: @booking.flight, row: seat[0..seat.length - 2], column: seat[seat.length - 1])
        sit.update(disponibility: true)
      end
      for seat in new_seats do
        sit = Seat.find_by(flight: @booking.flight, row: seat[0..seat.length - 2], column: seat[seat.length - 1])
        sit.update(disponibility: false)
      end
      redirect_to @booking
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    seats = params[:seats].split(";")
    if seats.length > 0 && seats[0].length < 4 && params[:user] != ''
      for seat in seats do
        puts("monu")
        puts(params[:flight_id], seat[0..seat.length - 2], seat[seat.length - 1])
        puts("monu")
        seat = Seat.find_by(flight: params[:flight_id], row: seat[0..seat.length - 2], column: seat[seat.length - 1])
        if seat
          seat = Seat.update(seat.id, disponibility: false)
        end
      end
      @booking = Booking.new(user: params[:user], seats: seats, flight: params[:flight_id])
      if @booking.save
        redirect_to "/flights/#{params[:flight_id]}"
      else
        render :index, status: :unprocessable_entity
      end
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy

    redirect_to root_path, status: :see_other
  end
end
