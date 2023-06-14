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
    if params[:post] == "likes"
      @posts = current_end_user.like_posts.order("created_at DESC")
    elsif params[:post] == "all"
      @posts = Post.all.order("created_at DESC")
    else
      cats = current_end_user.bookmark_cats
      #bookmarkしている猫の投稿をそれぞれ加えたあと、投稿日時が新しい順で並び替えしている
      @posts = cats.inject(init = []) {|result, cat| result + cat.posts}.sort_by(&:created_at).reverse
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = Comment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :body, :cat_id, :image)
  end
end
