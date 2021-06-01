class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      remember user
      params[:session][:remember_me] == Settings.controller.sessions.remember ? remember(user) : forget(user)
      redirect_to user
    else
      flash.now[:danger] = t "global.login_fail"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
