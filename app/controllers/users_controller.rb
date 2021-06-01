class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :find_user, except: %i(create new index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "global.success_text"
      redirect_to @user
    else
      flash.now[:danger] = t "global.error_text"
      render :new
    end
  end

  def edit; end

  def update
    @user = User.find_by id: params[:id]
    if @user.update user_params
      flash[:success] = t "global.edit.update_done"
      redirect_to @user
    else
      flash.now[:danger] = t "global.edit"
      render :edit
    end
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def destroy
    @user.destroy
    flash[:success] = t "global.user_delete"
    redirect_to users_url
  end


  private

  def user_params
    params.require(:user).permit User::USER_PERMIT
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "global.edit.message_login_fail"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user?(@user)
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t "global.not_found_user"
    redirect_to root_path
  end
end
