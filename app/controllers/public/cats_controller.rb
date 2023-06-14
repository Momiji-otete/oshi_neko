class Public::CatsController < ApplicationController
  def new
    @cat = Cat.new
  end

  def create
    @cat = current_end_user.cats.new(cat_params)
    if @cat.save
      redirect_to cat_path(@cat)
    else
      render :new
    end
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
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
end
