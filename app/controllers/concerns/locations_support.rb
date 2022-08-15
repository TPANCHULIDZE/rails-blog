module LocationsSupport

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