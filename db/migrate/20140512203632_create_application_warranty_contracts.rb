class CreateApplicationWarrantyContracts < ActiveRecord::Migration
  def change
    create_table :application_warranty_contracts, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :application_id, :null => false, :limit => 2
      t.integer :warranty_contract_id, :null => false, :limit => 2

      t.timestamps
    end
  end
end
