class Public::CatsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :find_cat, only: [:show, :edit, :update]
  before_action :permit_only_oneself, only: [:edit, :update]
  before_action :cannot_show_deleted_end_user, only: :show

  def new
    @cat = Cat.new
  end

  def create
    @cat = current_end_user.cats.new(cat_params)
    if @cat.save
      flash[:notice] = "猫を登録しました。"
      redirect_to cat_path(@cat)
    else
      render :new
    end
  end

  def show
    @posts = @cat.posts.order("created_at DESC").page(params[:post_page])
  end

  def edit
  end

  def update
    if @cat.update(cat_params)
      flash[:notice] = "変更を保存しました。"
      redirect_to cat_path(@cat)
    else
      render :edit
    end
  end

  def ranking
    #退会していないユーザーの猫のIDを配列にする
    valid_cat_ids = Cat.valid_cats.pluck(:id)
    #bookmarkのcat_idをvalid_cat_idsで絞込み、cat_idごとに分けた後、cat_idの数で並び替え、cat_idのみを配列にして返し、その数字を元にCatモデルからデータを10取得する
    @cats = Cat.find(Bookmark.where(cat_id: valid_cat_ids).group(:cat_id).order('count(cat_id) desc').limit(10).pluck(:cat_id))
  end


  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :introduction, :cat_image, :breed)
  end

  def find_cat
    @cat = Cat.find(params[:id])
  end

  #自分の猫かチェックする
  def permit_only_oneself
    end_user = @cat.end_user
    unless end_user == current_end_user
      redirect_to end_user_path(current_end_user)
    end
  end

  #退会したユーザーの猫は見られないようにする
  def cannot_show_deleted_end_user
    if @cat.end_user.is_deleted == true
      flash[:warning] = "退会したユーザーの猫は閲覧できません"
      redirect_to request.referer
    end
  end
end
