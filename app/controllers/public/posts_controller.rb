class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = current_end_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index

  end

  def show

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :cat_id, :image)
  end
end
