class WarrantyType < ActiveRecord::Base
  belongs_to :warranty_contracts
  validates :name, :presence => true, :uniqueness => true
 
  def self.getname(id)
    WarrantyType.find(id).name
    rescue ActiveRecord::RecordNotFound
      "None"
  end
end