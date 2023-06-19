class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  validates :name, presence: true

  def self.search_posts_for(search_word, method)
    if method == "perfect"
       tags = Tag.where(name: search_word)
    elsif method == "forward"
       tags = Tag.where("name LIKE ?", "#{search_word}%")
    elsif method == "backward"
       tags = Tag.where("name LIKE ?", "%#{search_word}")
    else
       tags = Tag.where("name LIKE ?", "%#{search_word}%")
    end

    search_post_ids = [] #空の配列を用意
    tags.each do |tag| #タグ検索で取得したタグをそれぞれ取り出す
      search_post_ids += tag.post_ids #タグが持っている投稿のidを取り出して代入
    end

    return Post.valid_posts.where(id: search_post_ids)

  end

end
