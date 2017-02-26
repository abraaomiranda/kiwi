class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_notifcations, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :name, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def set_notifcations
    @notifications = current_user.notifications.where(read: false)
  end

end
