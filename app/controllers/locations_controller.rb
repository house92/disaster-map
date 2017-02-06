class LocationsController < ApplicationController
  def index
    @disasters = Disaster.all
  end
end
