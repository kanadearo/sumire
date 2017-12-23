class Post < ApplicationRecord
  belongs_to :user
  
  mount_uploader :photo, PhotoUploader
  
  validates :user_id, presence: true
  validates :photo, presence: true
  validates :caption, length: {maximum:255}
  
  has_many :reverses_of_favorites, class_name: 'Favorite', foreign_key: 'post_id'
  has_many :favoriters, through: :reverses_of_favorites, source: :user
  
end
