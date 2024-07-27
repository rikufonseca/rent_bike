class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookings
  has_many :bikes, through: :bookings
  has_many :bikes
  has_many :favories
  has_many :messages
  has_many :messages, through: :bookings
  has_many :reviews, through: :bookings
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true, uniqueness: true
end
