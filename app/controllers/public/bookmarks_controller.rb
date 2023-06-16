class Public::BookmarksController < ApplicationController
  before_action :authenticate_end_user!

  def create
    cat = Cat.find(params[:cat_id])
    @bookmark = current_end_user.bookmarks.new(cat_id: cat.id)
    @bookmark.save
    render "replace_btn"
  end

  def destroy
    cat = Cat.find(params[:cat_id])
    @bookmark = current_end_user.bookmarks.find_by(cat_id: cat.id)
    @bookmark.destroy
    render "replace_btn"
  end

end
