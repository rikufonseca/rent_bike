class BikesController < ApplicationController
  def index
    @bikes = Bike.all

    if params[:address].present?
      sanitized_address = params[:address].gsub(/\b(Amsterdam|Netherlands)\b/, 'Amsterdam' => '!Amsterdam', 'Netherlands' => '!Netherlands')

      @bikes = Bike.search_by_address(sanitized_address)
    end

    @bikes = @bikes.where(price_per_day: 0..params[:price_per_day].to_i) if params[:price_per_day].present? && params[:price_per_day].to_i > 50

    @bikes = @bikes.where(bike_type: params[:bike_type]) if params[:bike_type].present? && params[:bike_type].reject!(&:blank?).any?

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
