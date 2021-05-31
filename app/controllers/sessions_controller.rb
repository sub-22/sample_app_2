class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
<<<<<<< HEAD
      params[:session][:remember_me] == Settings.controller.sessions.remember ? remember(user) : forget(user)
=======
>>>>>>> 8eddf8e (Chapter8: Basic Login)
      redirect_to user
    else
      flash.now[:danger] = t "global.login_fail"
      render :new
    end
  end

  def destroy
<<<<<<< HEAD
    log_out if logged_in?
=======
    log_out
>>>>>>> 8eddf8e (Chapter8: Basic Login)
    redirect_to root_path
  end
end
