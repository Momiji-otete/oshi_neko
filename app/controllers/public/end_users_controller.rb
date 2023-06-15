class Public::EndUsersController < ApplicationController
  before_action :reject_guest_user, only: [:edit]
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
    flash[:warning] = "退会処理が完了しました。"
    redirect_to root_path
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :email)
  end

  def reject_guest_user
    @end_user = EndUser.find(params[:id])
    if @end_user.name == "guestuser"
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to end_user_path(current_end_user)
    end
  end
end
