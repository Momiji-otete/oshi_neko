class Cat < ApplicationRecord
  belongs_to :end_user
  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy
end
