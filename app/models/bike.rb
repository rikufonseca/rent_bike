class Bike < ApplicationRecord
  include PgSearch::Model
  belongs_to :user
  has_many :bookings
  has_many :favorites
  has_many :reviews, through: :bookings
  has_many_attached :photos
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  pg_search_scope :search_by_address, against: [:address], using: { tsearch: { prefix: true } }

  BIKE_TYPES = %w[VTT Road Hybrid Cruiser BMX Folding Electric Touring Gravel Fat].freeze

  validates :price_per_day, presence: true
  validates :bike_type, inclusion: { in: BIKE_TYPES }
end
