class Bike < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :favorites
  has_many :reviews, through: :bookings
  has_many_attached :photos
  BIKE_TYPES = %w[VTT Road Hybrid Cruiser BMX Folding Electric Touring Gravel Fat].freeze

  validates :price_per_day, presence: true
  validates :bike_type, inclusion: { in: BIKE_TYPES }
end
