class Api::DeliveryV1::SessionsController < Devise::SessionsController
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }
  skip_before_filter :authenticate_user_from_token!
  before_filter :check_params
  respond_to :json

  def create
    version = '1'
    current_user = User.authenticate(params)
    if current_user
      render :status => 200,
      :json =>  { :success => "true",
                  :info => "Logged in",
                  :data => current_user }
    else
      failure
    end
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
  end

  def check_params
    unless params[:phone].present?
      failure
    end
  end
end