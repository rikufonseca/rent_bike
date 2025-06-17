class BookingsController < ApplicationController

  def index
      @bookings = current_user.bookings if user_signed_in?
  end
  def create
    range = params[:booking][:start_date].split(" to ")
    @booking = Booking.new(start_date: range[0], end_date: range[1])
    @bike = Bike.find(params[:bike_id])
    @booking.bike = @bike
    @booking.user = current_user
    if @booking.save!
      redirect_to root_path, notice: 'Booking was successfully created.'
    else
      render :new
    end
  end
end
