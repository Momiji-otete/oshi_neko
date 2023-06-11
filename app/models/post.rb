class Post < ApplicationRecord
  belongs_to :end_user
  belongs_to :cat
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  has_one_attached :image

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

  def save_tags(savepost_tags)
    # 既にその投稿に基づいたタグがあればタグのnameをcurrent_tagsに代入
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 新しく保存されたタグとの差分をそれぞれ変数に代入する
    old_tags = current_tags - savepost_tags
    new_tags = savepost_tags - current_tags

    #古いタグの削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    #新しいタグの保存
    new_tags.each do |new_name|
      book_tag = Tag.find_or_create_by(name: new_name)
      self.tags << book_tag
    end
  end


end
