class SeatsController < ApplicationController
  def new
    @seat = Seat.new
  end

  def create
    @seat = Seat.new(seat_params)

    if @seat.save
      redirect_to @seat
    else
      render :new, status: :unprocessable_entity
    end
  end
  private
    def seat_params
      params.require(:seat).permit(:row, :column, :disponibility)
    end

end
