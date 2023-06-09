class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :permit_only_oneself, only: [:edit, :update]
  before_action :cannot_show_deleted_end_user, only: :show

  def new
    @post = Post.new
    #猫を登録していない状態だと猫登録に遷移させる
    redirect_to new_cat_path, notice: "猫の登録から行ってください。" unless current_end_user.cats.exists?
  end

  def create
    @post = current_end_user.posts.new(post_params)
    #送られてきたtag_nameの区切り文字を半角スペースに変換し、文字列前後の余計な空白を除去し、
    #半角スペースで区切って配列にする、uniqで重複しているタグがあれば削除する
    tag_list = params[:post][:tag_name].gsub(/[　,、]/, " ").strip.split(/ +/).uniq
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
      @posts = current_end_user.like_posts.valid_posts.order("created_at DESC").page(params[:post_page])
    elsif params[:post] == "all"
      @posts = Post.valid_posts.order("created_at DESC").page(params[:post_page])
    else
      #自分の猫とブックマークしている猫のidを*で展開し、そのidとcat_idが一致する投稿をDBからもってくる
      @posts = Post.valid_posts.where(cat_id: [*current_end_user.cat_ids, *current_end_user.bookmark_cat_ids]).order("created_at DESC").page(params[:post_page])
    end
  end

  def show
    @post_comment = Comment.new
  end

  def edit
    @tag_list = @post.tags.pluck(:name).join(',')
  end

  def update
    tag_list = params[:post][:tag_name].gsub(/[　,、]/, " ").strip.split(/ +/).uniq
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

  #自分の投稿かチェックする
  def permit_only_oneself
    unless @post.end_user == current_end_user
      redirect_to posts_path
    end
  end

  #退会したユーザーの投稿は見られないようにする
  def cannot_show_deleted_end_user
    if @post.end_user.is_deleted == true
      flash[:warning] = "退会したユーザーの投稿は閲覧できません"
      redirect_to posts_path
    end
  end
end
