class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :reject_guest_user, only: :edit
  before_action :find_end_user, only: [:show, :edit, :update]
  before_action :permit_only_oneself, only: [:edit, :update]
  before_action :cannot_show_deleted_end_user, only: :show

  def show
    @cats = @end_user.cats.page(params[:cat_page]).per(3)
    @posts = @end_user.posts.order("created_at DESC").page(params[:post_page])
  end

  def edit
  end

  def update
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

  def bookmark_cats
    @end_user = EndUser.find(params[:end_user_id])
    @cats = @end_user.bookmark_cats.valid_cats.page(params[:cat_page]).per(6)
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :introduction, :email)
  end

  def find_end_user
    @end_user = EndUser.find(params[:id])
  end

  #ユーザーが自身かチェックする
  def permit_only_oneself
    unless @end_user == current_end_user
      redirect_to end_user_path(current_end_user)
    end
  end

  #退会したユーザー情報は見られないようにする
  def cannot_show_deleted_end_user
    if @end_user.is_deleted == true
      flash[:warning] = "退会したユーザー情報は閲覧できません"
      redirect_to posts_path
    end
  end

  # ゲストユーザーはユーザー情報を編集できなくする
  def reject_guest_user
    find_end_user
    if @end_user.name == "guestuser"
      flash[:notice] = "ゲストユーザーはプロフィール編集画面へ遷移できません。"
      redirect_to end_user_path(current_end_user)
    end
  end
end
