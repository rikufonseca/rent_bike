class Message < ApplicationRecord
  belongs_to :user
  belongs_to :bike, through: :bookings
  belongs_to :booking
  TYPE = %w[report message].freeze

  enum type: {
    report: 'report',
    message: 'message'
  }

  validates :type, presence: true, inclusion: { in: TYPE }
  validates :messages, presence: true
end
