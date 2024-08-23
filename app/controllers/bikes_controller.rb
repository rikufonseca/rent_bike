class BikesController < ApplicationController
  def index
    @bikes = Bike.all

    if params[:address].present?
      sanitized_address = params[:address].gsub(/\b(Amsterdam|Netherlands)\b/, 'Amsterdam' => '!Amsterdam', 'Netherlands' => '!Netherlands')

      @bikes = Bike.search_by_address(sanitized_address)
    end

    @bikes = Bike.all if @bikes.empty?

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
    @bike = Bike.find(params[:id])
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
