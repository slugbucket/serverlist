class WarrantyContract < ActiveRecord::Base
  has_one :warranty_type
  has_one :vendor
  
  def self.getname(id)
    WarrantyContract.find(id).name
    rescue ActiveRecord::RecordNotFound
      "None"
  end
end
