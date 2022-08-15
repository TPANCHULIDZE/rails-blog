class LocationsController < ApplicationController
  before_action :require_user_signed_in!

  def index
    @user = User.find_by(id: params[:user_id])
    @locations = @user.locations
  end

  def show
    @location = Location.find_by(id: params[:id])
  end

  def new
    @location = Location.new()
  end

  def create
    @location = current_user.locations.new(locations_params)
    locations_coordinates = place_coordinates
    if locations_coordinates
      @location.latitude = locations_coordinates.first
      @location.longitude = locations_coordinates.second
      @location.save
      redirect_to profile_path(current_user)  
    else
      render :new
    end
  end

  def destroy
    @location = Location.find_by(id: params[:id])
    @location.destroy
    redirect_to profile_path(params[:user_id])
  end

  private 

  def locations_params
    params.require(:location).permit(:street, :city, :state, :country)
  end

  def place_coordinates
    objects = Geocoder.search(@location.address)
    if !objects.empty?
      data = objects.first.data
    else
      return 
    end
    [data["lat"], data["lon"]]
  end
end
