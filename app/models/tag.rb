class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destory
  has_many :posts, through: :post_tags
end
