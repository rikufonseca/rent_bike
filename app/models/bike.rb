class Bike < ApplicationRecord
  belongs_to :user
  has_many :bookings
  TYPE = %w[VTT Road Hybrid Cruiser BMX Folding Electric Touring Gravel Fat].freeze

  enum type: {
    VTT: 'VTT',
    Road: 'Road',
    Hybrid: 'Hybrid',
    Cruiser: 'Cruiser',
    BMX: 'BMX',
    Folding: 'Folding',
    Electric: 'Elecytric',
    Touring: 'Touring',
    Gravel: 'Gravel',
    Fat: 'Fat'
  }
  validates :price_per_day, presence: true
  validates :type, presence: true, inclusion: { in: TYPE }
end
