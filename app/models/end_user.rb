class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :cats, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_cats, through: :bookmarks, source: :cat


  def bookmarked?(cat)
    bookmark_cats.include?(cat)
  end

  def own_cats?(cat)
    cats.include?(cat)
  end
  
  def self.search_for(search_word, method)
    if method == "perfect"
      EndUser.where(name: search_word)
    elsif method == "forward"
      EndUser.where("name LIKE ?", "#{search_word}%")
    elsif method == "backward"
      EndUser.where("name LIKE ?", "%#{search_word}")
    else
      EndUser.where("name LIKE ?", "%#{search_word}%")
    end
  end

end