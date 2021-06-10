class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach params[:micropost][:image]
    if @micropost.save
      flash[:success]  = t "microposts.message.success"
      redirect_to root_url
    else
      @feed_items = current_user.feed.order_post.page(params[:page]).per Settings.users_micropost.page
      flash.now[:danger] = t "microposts.message.danger"
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t "microposts.message.delete"
    else
      flash.now[:danger] = t "microposts.message.delete_err"
    end
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit Micropost::MICROPOSTS_PERMIT
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost

    flash.now[:danger] = t "microposts.message.danger"
  end
end
