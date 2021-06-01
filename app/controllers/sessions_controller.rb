class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
<<<<<<< HEAD
<<<<<<< HEAD
      params[:session][:remember_me] == Settings.controller.sessions.remember ? remember(user) : forget(user)
=======
>>>>>>> 8eddf8e (Chapter8: Basic Login)
=======
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
>>>>>>> 4f88919 (Chapter9: Advanced login)
      redirect_to user
    else
      flash.now[:danger] = t "global.login_fail"
      render :new
    end
  end

  def destroy
<<<<<<< HEAD
<<<<<<< HEAD
    log_out if logged_in?
=======
    log_out
>>>>>>> 8eddf8e (Chapter8: Basic Login)
=======
    log_out if logged_in?
>>>>>>> 4f88919 (Chapter9: Advanced login)
    redirect_to root_path
  end
end
