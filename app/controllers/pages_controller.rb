class PagesController < ApplicationController
  def landing
    @bikes = Bike.all
  end
end
