class Article < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_one_attached :photo
  has_rich_text :body
  validates :title, presence: true
  validates :status, presence: true

  has_many :comments, dependent: :destroy
  belongs_to :user
end
