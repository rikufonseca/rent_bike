class PagesController < ApplicationController
  def landing
    @bikes = Bike.all

    @markers = @bikes.geocoded.map do |bike|
      {
        lat: bike.latitude,
        lng: bike.longitude,
        info_window_html: render_to_string(partial: "bikes/info_window", locals: { bike: bike }),
        marker_html: render_to_string(partial: "bikes/marker")
      }
    end
  end
end
