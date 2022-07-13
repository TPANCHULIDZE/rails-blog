class Location < ApplicationRecord
  belongs_to :user
  geocoded_by :address
  after_validation :geocode

  def address
    [street, city, state, country].compact.join(", ")
  end

  def coordinates
    [self.latitude, self.longitude]
  end

end
