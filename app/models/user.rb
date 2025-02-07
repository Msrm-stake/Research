class User < ApplicationRecord
  has_one :community, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :attendances
  has_many :attended_events, through: :attendances, source: :event
  has_many :event_attendees

  
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }

  def full_name
    if first_name.present? && last_name.present?
      "#{first_name} #{last_name}"
    elsif first_name.present?
      first_name
    elsif last_name.present?
      last_name
    else
      email.split('@').first.capitalize # Fallback to email username
    end
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
