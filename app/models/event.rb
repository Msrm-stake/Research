class Event < ApplicationRecord
  belongs_to :community
  belongs_to :user  # The event creator
  has_one_attached :photo # Make sure this line exists
  has_many :attendances
  has_many :attendees, through: :attendances, source: :user
  has_many :event_attendees


  validates :name, :description, :date, :time, :place, :photo, presence: true
end
