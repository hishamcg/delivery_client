class StoreLocation < BaseResource
  def self.find_all
    self.prefix = "/api/v1/"
    StoreLocation.find(:all)
  end
end
