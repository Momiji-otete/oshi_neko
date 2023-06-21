class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, only: :search

  def top
    if Cat.first.present?
      @rand_cats = Cat.where('id >= ?', rand(Cat.first.id..Cat.last.id)).limit(3)
    else
      @rand_cats = []
    end

    @posts = Post.valid_posts.order("created_at DESC").limit(3)
  end

  def about
  end

  def search
    @model = params[:model]
    @search_word = params[:search_word]
    @method = params[:method]
    if @model == "cat"
      @results = Cat.valid_cats.search_for(@search_word, @method).page(params[:page]).per(6)
    elsif @model == "post"
      @results = Post.valid_posts.search_for(@search_word, @method).page(params[:page])
    else #"tag"
      @results = Tag.search_posts_for(@search_word, @method).page(params[:page])
    end
  end
end
