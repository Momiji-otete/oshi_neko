class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :permit_only_oneself, only: [:edit, :update]

  def new
    @post = Post.new
    #猫を登録していない状態だと猫登録に遷移させる
    redirect_to new_cat_path, notice: "猫の登録から行ってください。" unless current_end_user.cats.exists?
  end

  def create
    @post = current_end_user.posts.new(post_params)
    #送られてきたtag_nameをカンマで区切って配列にする
    tag_list = params[:post][:tag_name].split(',')
    if @post.save
      @post.save_tags(tag_list)
      flash[:notice] = "投稿しました。"
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def index
    if params[:post] == "likes"
      @posts = current_end_user.like_posts.order("created_at DESC").page(params[:page])
    elsif params[:post] == "all"
      @posts = Post.all.order("created_at DESC").page(params[:page])
    else
      #自分の猫とブックマークしている猫のidを*で展開し、そのidとcat_idが一致する投稿をDBからもってくる
      @posts = Post.where(cat_id: [*current_end_user.cat_ids, *current_end_user.bookmark_cat_ids]).order("created_at DESC").page(params[:page])
    end
  end

  def show
    @post_comment = Comment.new
  end

  def edit
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:post][:tag_name].split(',')
    if @post.update(post_params)
      @post.save_tags(tag_list)
      flash[:notice] = "変更を保存しました。"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:warning] = "投稿を削除しました。"
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :cat_id, :image)
  end

  def find_post
    @post = Post.find(params[:id])
  end

  def permit_only_oneself
    end_user = @post.end_user
    unless end_user == current_end_user
      redirect_to posts_path
    end
  end
end
