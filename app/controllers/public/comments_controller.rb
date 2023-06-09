class Public::CommentsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    post = Post.find(params[:post_id])
    @comment = current_end_user.comments.new(comment_params)
    @comment.post_id = post.id
    # 非同期でエラーメッセージを返す
    render "validater" unless @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
  end


  private

  def comment_params
    params.require(:comment).permit(:comment_content)
  end
end
