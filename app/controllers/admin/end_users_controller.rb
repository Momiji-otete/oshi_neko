class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :find_end_user, only: [:show, :edit, :update]

  def show
    @cats = @end_user.cats.page(params[:page]).per(3)
  end

  def edit
  end

  def update
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user)
      flash[:notice] = "ステータスを変更しました。"
    else
      render :edit
    end
  end

  def posts_index
    @end_user = EndUser.find(params[:end_user_id])
    @posts = @end_user.posts.order("created_at DESC").page(params[:page])
  end


  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :email, :is_deleted)
  end

  def find_end_user
    @end_user = EndUser.find(params[:id])
  end
end
