class Post < ApplicationRecord
  belongs_to :end_user
  belongs_to :cat
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destory
  has_many :tags, through: :post_tags
end
