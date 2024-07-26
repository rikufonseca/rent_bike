class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :bike
  has_many :reviews
  has_many :messages, dependent: :destroy
  STATUS = %w[unconfirmed confirmed done rejected].freeze

  enum status: {
    unconfirmed: 'unconfirmed',
    rejected: 'rejected',
    confirmed: 'confirmed',
    done: 'done'
  }

  validates :status, presence: true, inclusion: { in: STATUS }
  validates :start_date, :end_date, presence: true
end
