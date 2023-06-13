class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  def self.search_books_for(search_word, method)
    if method == "perfect"
       tags = Tag.where(name: search_word)
    elsif method == "forward"
       tags = Tag.where("name LIKE ?", "#{search_word}%")
    elsif method == "backward"
       tags = Tag.where("name LIKE ?", "%#{search_word}")
    else
       tags = Tag.where("name LIKE ?", "%#{search_word}%")
    end

    return tags.inject(init = []) {|result, tag| result + tag.posts }
  end

end
