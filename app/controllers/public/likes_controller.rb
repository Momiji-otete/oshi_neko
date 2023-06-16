class Public::LikesController < ApplicationController
  before_action :authenticate_end_user!

  def create
    post = Post.find(params[:post_id])
    @like = current_end_user.likes.new(post_id: post.id)
    @like.save
    render 'replace_btn'
  end

  def destroy
    post = Post.find(params[:post_id])
    @like = current_end_user.likes.find_by(post_id: post.id)
    @like.destroy
    render 'replace_btn'
  end
end
