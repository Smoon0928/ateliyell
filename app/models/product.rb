class Product < ApplicationRecord
  
  belongs_to :user
  has_many_attached :images
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  #通知機能
  has_many :notifications, dependent: :destroy
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :images, presence: true
  validates :genre, presence: true
  
  scope :latest, -> {order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  def create_notification_like!(current_user)
    #既に「いいね」されているか検索(いいねを連続で押しても1度しか通知いかない)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and product_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    #いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        product_id: id,
        visited_id: user_id,
        action: 'like'
        )
    #自分の投稿に対するいいねの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
  
  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(product_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      product_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  
        
  enum status: {public: 0,private:1 },_prefix: true
end
