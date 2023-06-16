class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @end_users = EndUser.all.page(params[:page])
  end

  def search
    @model = params[:model]
    @search_word = params[:search_word]
    @method = params[:method]
    if @model == "end_user"
      @results = EndUser.search_for(@search_word, @method)
    elsif @model == "post"
      @results = Post.search_for(@search_word, @method)
    else #"tag"
      @results = Tag.search_books_for(@search_word, @method)
    end
  end
end
