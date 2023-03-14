class Product < ApplicationRecord
  
  belongs_to :user
  has_many_attached :images
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :images, presence: true
  validates :genre, presence: true
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
