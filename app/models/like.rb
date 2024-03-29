class Like < ApplicationRecord
  validates_uniqueness_of :product_id, scope: :user_id
  
  belongs_to :user
  belongs_to :product
end
