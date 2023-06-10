class Public::BookmarksController < ApplicationController
  def create
    cat = Cat.find(params[:cat_id])
    current_end_user.bookmark(cat)
    redirect_to request.referer
  end

  def destroy
    cat = Cat.find(params[:cat_id])
    current_end_user.drop_bookmark(cat)
    redirect_to request.referer
  end

end
