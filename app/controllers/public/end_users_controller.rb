class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    @cats = @end_user.cats
    @posts = @end_user.posts
  end

  def edit

  end

  def update
  end

  def withdraw_confirm
  end

  def withdraw
  end
end
