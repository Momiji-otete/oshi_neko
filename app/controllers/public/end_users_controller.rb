class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    @cats = @end_user.cats
    @posts = @end_user.posts
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(current_end_user)
    else
      render :edit
    end
  end

  def withdraw_confirm
  end

  def withdraw
    current_end_user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def end_user_params
    params.require(:end_user).permit(:name, :introduction)
  end
end
