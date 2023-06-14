class Public::HomesController < ApplicationController
  def top
    @rand_cats = Cat.where('id >= ?', rand(Cat.first.id..Cat.last.id)).limit(3)
    @posts = Post.joins(:end_user).where(end_user: { is_deleted: false }).order("created_at DESC").limit(3)
  end

  def about
  end

  def search
    @model = params[:model]
    @search_word = params[:search_word]
    @method = params[:method]
    if @model == "cat"
      @results = Cat.search_for(@search_word, @method)
    elsif @model == "post"
      @results = Post.search_for(@search_word, @method)
    else #"tag"
      @results = Tag.search_books_for(@search_word, @method)
    end
  end
end
