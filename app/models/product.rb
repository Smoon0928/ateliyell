class Product < ApplicationRecord
  
  belongs_to :user
  has_many_attached :images
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
