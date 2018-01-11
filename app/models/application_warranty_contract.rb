class ApplicationWarrantyContract < ActiveRecord::Base
  belongs_to :application
  belongs_to :warranty_contract
end
