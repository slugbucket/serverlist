class CreateWarrantyContracts < ActiveRecord::Migration
  def change
    create_table :warranty_contracts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.text :description
      t.integer :vendor_id, :limit =>2 
      t.integer :warranty_type_id, :limit =>2 
      t.date :expiry

      t.timestamps
    end
  end
end
