class Community < ApplicationRecord
  belongs_to :user
  mount_uploader :profile_picture, ProfilePictureUploader
  has_many :articles, dependent: :destroy
  has_many :events, dependent: :destroy
    
  GROUPS = ["Research fellows", "Researchers", "Faculty & convening"]
  # Validations
  validates :first_name, :last_name, :description, presence: true
  validates :group, presence: true, inclusion: { in: GROUPS }

  validates :user_id, uniqueness: true
end
