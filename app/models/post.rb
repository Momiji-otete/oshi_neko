class Post < ApplicationRecord
  belongs_to :end_user
  belongs_to :cat
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_one_attached :image
  
  validates :title, presence: true
  validates :body, presence: true
  validates :cat_id, presence: true

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  def liked_by?(end_user)
    likes.exists?(end_user_id: end_user.id)
  end
  
  def self.search_for(search_word, method)
    if method == "perfect"
      Post.where(title: search_word)
    elsif method == "forward"
      Post.where("title LIKE ?", "#{search_word}%")
    elsif method == "backward"
      Post.where("title LIKE ?", "%#{search_word}")
    else
      Post.where("title LIKE ?", "%#{search_word}%")
    end
  end
  
end
