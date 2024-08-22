class BikesController < ApplicationController
  def index
    if params[:research].present?
      @bikes = Bike.where('address ILIKE ?', "%#{params[:research]}%")

      if @bikes.empty?
        flash.now[:alert] = "Aucun vélo trouvé pour la recherche '#{params[:research]}'"
        @bikes = Bike.all # Optionally show all bikes if no matches
      end
    else
      @bikes = Bike.all
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
