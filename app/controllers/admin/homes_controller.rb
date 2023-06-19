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
      @results = EndUser.search_for(@search_word, @method).page(params[:page])
    elsif @model == "post"
      @results = Post.search_for(@search_word, @method).page(params[:page])
    else #"tag"
      @results = Tag.search_posts_for(@search_word, @method).page(params[:page])
    end
  end
end
