class Cat < ApplicationRecord
  belongs_to :end_user
  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  enum sex: { unanswered: 0, male: 1, female: 2 }
end
