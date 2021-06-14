class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  private

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    flash.now[:danger] = t "relationship.danger"
    redirect_to root_url
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t "global.edit.message_login_fail"
    redirect_to login_url
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
