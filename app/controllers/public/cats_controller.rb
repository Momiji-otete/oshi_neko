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

  end

  def edit

  end

  def update

  end
end
