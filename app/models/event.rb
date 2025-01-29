class Event < ApplicationRecord
  belongs_to :community
  has_many :event_attendances, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :event_attendances, source: :user
  has_one_attached :photo

  # Validate presence of an image (optional)
  
end
