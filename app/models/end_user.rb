class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :cats, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_cats, through: :bookmarks, source: :cat
  
  def bookmark(cat)
    bookmarks.create(cat_id: cat.id)
  end
  
  def drop_bookmark(cat)
    bookmarks.find_by(cat_id: cat.id).destroy
  end
  
  def bookmarked?(cat)
    bookmark_cats.include?(cat)
  end
end
