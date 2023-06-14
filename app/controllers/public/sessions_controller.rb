# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_deleted_end_user, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    flash[:notice] = "ゲストユーザーでログインしました"
    redirect_to end_user_path(end_user)
  end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def reject_deleted_end_user
    @end_user = EndUser.find_by(email: params[:end_user][:email])
    return unless @end_user
    if @end_user.valid_password?(params[:end_user][:password]) && @end_user.is_deleted
      flash[:danger] = "お客様は退会済みです。申し訳ありませんが、再度登録をお願いします。"
      redirect_to new_end_user_registration_path
    end
  end
end
