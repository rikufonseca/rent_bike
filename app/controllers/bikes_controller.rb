class BikesController < ApplicationController
  def index

     @bikes = Bike.all

    if params[:query].present?
      @bikes = Bike.where('address ILIKE ?', "%#{params[:query]}%")
    end

    respond_to do |format|
      format.html
      format.html { render partial: 'list', locals: { bikes: @bikes } }
      format.any { head :not_acceptable }
    end

    @markers = @bikes.geocoded.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: { bike: bike }),
        marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def top
  end

  def destroy
  end
end
