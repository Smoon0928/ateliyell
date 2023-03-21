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
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  scope :like_count, -> {order(likes: :desc)}
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  enum status: {public: 0,private:1 },_prefix: true
end
