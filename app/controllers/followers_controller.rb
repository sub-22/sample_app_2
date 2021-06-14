class FollowersController < ApplicationController
  before_action :logged_in_user, :find_user

  def index
    @title = t "follow.followers"
    @users = @user.followers.page(params[:page]).per Settings.follow.page
    render "users/show_follow"
  end
end
