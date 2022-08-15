class Location < ApplicationRecord
  belongs_to :user
  geocoded_by :address
  after_validation :geocode


  validates :latitude, presence: true
  validates :longitude, presence: true

  def address
    [street, city, state, country].compact_blank.join(", ")
  end
end
