class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  belongs_to :genre
end
