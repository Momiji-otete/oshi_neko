class Cat < ApplicationRecord
  belongs_to :end_user
  has_many :bookmarks, dependent: :destroy
  has_many :posts, dependent: :destroy

  scope :valid_cats, -> { joins(:end_user).where(end_user: { is_deleted: false })}

  enum sex: { unanswered: 0, male: 1, female: 2 }

  has_one_attached :cat_image

  validates :name, presence: true, length: { maximum: 12 }
  validates :introduction, length: { maximum: 200 }
  

  def get_cat_image(width, height)
    unless cat_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      cat_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    cat_image.variant(resize_to_limit: [width, height]).processed
  end
  
  #自分の猫かチェックする
  def is_own_cat?(current_end_user)
    end_user == current_end_user
  end

  def self.search_for(search_word, method)
    if method == "perfect"
      Cat.where(breed: search_word)
    elsif method == "forward"
      Cat.where("breed LIKE ?", "#{search_word}%")
    elsif method == "backward"
      Cat.where("breed LIKE ?", "%#{search_word}")
    else
      Cat.where("breed LIKE ?", "%#{search_word}%")
    end
  end
end
