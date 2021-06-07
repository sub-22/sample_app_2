class PasswordResetsController < ApplicationController
  before_action :get_user, :valid_user, :check_expiration, only: %i(edit update)

  def new; end

  def create
    @user = User.find_by email: params[:password_reset][:email].downcase
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:infor] = t "global.reset_pass.infor_text"
      redirect_to root_url
    else
      flash.now[:danger] = t "global.reset_pass.not_found_email"
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:password].blank?
      @user.errors.add :password, t("user_mailer.reset_pass.check_empty")
      render :edit
    elsif @user.update user_params
      log_in @user
      @user.update_attribute :reset_digest, nil
      flash[:success] = t "user_mailer.reset_pass.success_change"
      redirect_to @user
    else
      flash.now[:danger] = t "user_mailer.reset_pass.reset_fail"
      render :edit
    end
  end

  private

  def user_params
    params.required(:user).permit :password, :password_confirm
  end

  def get_user
    @user = User.find_by email: params[:email]
    return if @user

    flash[:danger] = t "user_mailer.reset_pass.not_found_email"
    redirect_to root_url
  end

  def valid_user
    return if @user&.activated? && @user.authenticated?(:reset, params[:id])

    redirect_to root_url
  end

  def check_expiration
    return unless @user.password_reset_expired?

    flash[:danger] = t "user_mailer.reset_pass.expired"
    redirect_to new_password_reset_url
  end
end
