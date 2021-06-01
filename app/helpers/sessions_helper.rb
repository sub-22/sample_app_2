module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
<<<<<<< HEAD
<<<<<<< HEAD
    if user_id = session[:user_id]
      @current_user ||= User.find_by id: user_id
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by id: user_id
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
=======
    if session[:user_id]
      @current_user ||= User.find_by id: session[:user_id]
>>>>>>> 8eddf8e (Chapter8: Basic Login)
=======
    if (user_id = session[:user_id])
      @current_user ||= User.find_by id: session[:user_id]
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by id: cookies.signed[:user_id]
      if user&.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
>>>>>>> 4f88919 (Chapter9: Advanced login)
    end
  end

  def logged_in?
    current_user.present?
  end

  def log_out
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4f88919 (Chapter9: Advanced login)
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def remember user
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget user
    user.forget
    cookies.delete :user_id
    cookies.delete :remember_token
  end
<<<<<<< HEAD
=======
    session.delete :user_id
    @current_user = nil
  end
>>>>>>> 8eddf8e (Chapter8: Basic Login)
=======
>>>>>>> 4f88919 (Chapter9: Advanced login)
end
