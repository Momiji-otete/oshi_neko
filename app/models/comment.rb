class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post

  validates :comment_content, presence: true, length: { maximum: 250 }
end
