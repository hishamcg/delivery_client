class DeliveryCrossReference < BaseResource
  def self.find_by_phone(phone)
    find(:all, :from => "/api/delivery_v1/delivery_plans/delivery_person.json", :params => { :phone => phone }).try(:first)
  end

  def self.find_todays_orders(id,date,slot_id)
    find(:all, :from => "/api/delivery_v1/delivery_plans/delivery_order.json", :params => { :delivery_person_id => id, :date => date ,:slot_id => slot_id})
  end

  def self.pickup(membership_no,book_number,username,branch_id,pickup_order_id)
    find(:one, :from => "/api/delivery_v1/delivery_plans/pickup.json", :params => {:membership_no => membership_no,:book_number => book_number,:username => username,:branch_id => branch_id,:pickup_order_id => pickup_order_id})
  end

  def self.issue(membership_no,book_number,username,branch_id,pickup_order_id)
    find(:one, :from => "/api/delivery_v1/delivery_plans/issue.json", :params => {:membership_no => membership_no,:book_number => book_number,:username => username,:branch_id => branch_id,:delivery_order_id => pickup_order_id})
  end
end