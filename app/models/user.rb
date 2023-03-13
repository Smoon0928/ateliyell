class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :profile_image
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  #フォロー、フォロワー機能のアソシエーション
  has_many :friends, class_name: "Friend", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_friends, class_name: "Friend", foreign_key: "follow_id", dependent: :destroy
  #フォロー、フォロワー機能のアソシエーション(一覧画面で使用)
  has_many :followings, through: :friends, source: :follow
  has_many :followers, through: :reverse_of_friends, source: :follower
  
  validates :user_name, presence: true
  
  def get_profile_image(width, height)
    unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  # フォローしたときの処理
  def follow(user_id)
    friends.create(follow_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    friends.find_by(follow_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
end
  
  #仮設定のフォローフォロワー記述
  #def followings
    #[]
  #end
  
  #def followers
    #[1, 2]
  #end

