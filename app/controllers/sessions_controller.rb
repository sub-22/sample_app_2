class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      check_activated user
    else
      flash.now[:danger] = t "global.login_fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private
  def check_activated user
    if user.activated?
      log_in user
      params[:session][:remember_me] == Settings.controller.sessions.remember ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash[:warning] = t "global.not_activate"
      redirect_to root_url
    end
  end
end
