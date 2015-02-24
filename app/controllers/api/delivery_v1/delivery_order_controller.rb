class  Api::DeliveryV1::DeliveryOrderController < ApplicationController
  respond_to :json,:xml

  def index
    array_out = []
    p @current_user
    member_order = DeliveryCrossReference.find_todays_orders(@current_user.delivery_person_id, params[:date], params[:slot_id])#.group_by(&:membership_no)
    member_order.collect(&:attributes).each do |goo|
      array_out << goo["delivery_person"].attributes
    end
    render :status => 200,
           :json => { :success => "true",
                      :info => "Logged in",
                      :data => array_out}
  end

  def pickup
    member_order = DeliveryCrossReference.pickup(params[:membership_no],params[:book_number],
                    "delivery_app_#{@current_user.name}",params[:branch_id],params[:pickup_order_id]).attributes
    if member_order["errors"].present?
      success = false
      errors = member_order["errors"].attributes
    else
      success = true
      errors = {}
    end
    render :status => 200,
           :json => { :success => success,
                      :book_number => member_order["book_id"],
                      :errors => errors}
  end

  def issue
    member_order = DeliveryCrossReference.issue(params[:membership_no],params[:book_number],
                    "delivery_app_#{@current_user.name}",params[:branch_id],params[:delivery_order_id]).attributes
    render :status => 200,
           :json => { :success => member_order["success"],
                      :book_number => member_order["book_number"],
                      :errors => member_order["errors"].attributes }
  end
end