class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.order("created_at DESC").page(params[:page])
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    Post.find(params[:id]).destroy
    flash[:warning] = "投稿を削除しました。"
    redirect_to admin_posts_path
  end

end
