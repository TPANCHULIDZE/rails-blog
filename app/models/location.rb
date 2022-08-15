class Location < ApplicationRecord
  include LocationAddress

  belongs_to :user
  geocoded_by :address
  after_validation :geocode


  validates :latitude, presence: true
  validates :longitude, presence: true
end
