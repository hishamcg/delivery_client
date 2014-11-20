class ApplicationController < ActionController::Base
  before_filter :authenticate_user_from_token!
  # before_filter :authenticate_user!
  protect_from_forgery

  def authenticate_user_from_token!
    user_phone = params[:phone]
    user = User.find_by_phone(user_phone) if user_phone.presence
    if user.presence && Devise.secure_compare(user.authentication_token, params[:api_key])
      @current_user = user
    else
      render :json => {"info" => "Not a valid user", :success => "false"}, :status => :unauthorized
    end

  end
end
