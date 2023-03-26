class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :phone_number, presence: true
  validates :user_name, length: { minimum: 2, maximum: 10 }, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  validates :first_name_kana, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/, message: 'はカタカナで入力して下さい。'}
  
  has_one_attached :profile_image
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :post
  #フォロー、フォロワー機能のアソシエーション
  has_many :friends, class_name: "Friend", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_friends, class_name: "Friend", foreign_key: "follow_id", dependent: :destroy
  #フォロー、フォロワー機能のアソシエーション(一覧画面で使用)
  has_many :followings, through: :friends, source: :follow
  has_many :followers, through: :reverse_of_friends, source: :follower
  
  
  
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
    p friends
    friends.find_by(follow_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end
  
  def liked_by?(product_id)
    likes.where(product_id: product_id).exists?
  end
  def self.ransackable_attributes(auth_object = nil)
    ["user_name"]
  end
  
  def self.guest
    find_or_create_by!(user_name: 'guestuser', last_name: "guest_user", first_name: "あいう", last_name_kana: "アイウ", first_name_kana: "アイウ", phone_number: "00000000000",  email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.user_name = "guestuser"
    end
  end

end