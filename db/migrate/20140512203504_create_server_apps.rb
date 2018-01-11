class CreateServerApps < ActiveRecord::Migration
  def change
    create_table :server_apps, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.text :description
      t.integer :vendor_id, :null => false, :limit => 2
      t.integer :warranty_contract_id, :limit => 2

      t.timestamps
    end
  end
end
