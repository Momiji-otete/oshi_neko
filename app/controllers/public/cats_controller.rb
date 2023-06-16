class Public::CatsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :permit_only_oneself, only: [:edit, :update]

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
    @cat = Cat.find(params[:id])
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
    @cats = Cat.find(Bookmark.group(:cat_id).order('count(cat_id) desc').limit(10).pluck(:cat_id))
  end


  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :introduction, :cat_image, :breed)
  end

  def permit_only_oneself
    @cat = Cat.find(params[:id])
    end_user = @cat.end_user
    unless end_user == current_end_user
      redirect_to end_user_path(current_end_user)
    end
  end
end
