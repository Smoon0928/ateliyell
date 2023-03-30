class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product
  #通知機能
  has_many :notifications, dependent: :destroy
end
