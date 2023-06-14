class Public::HomesController < ApplicationController
  def top
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
