class Vendor < ActiveRecord::Base
  belongs_to :cert
  belongs_to :server_app
  belongs_to :warranty_contract
  belongs_to :model

  def self.getname(id)
    Vendor.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
