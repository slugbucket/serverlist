class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 20, :default => 'hostname'
      t.integer :location_id, :null => false, :limit => 2
      t.text :primary_use
      t.integer :ad_domain_id, :limit =>2 
      t.integer :oob_remote_mngmt_id, :limit => 2
      t.integer :operating_system_id, :limit => 2
      t.integer :model_id, :limit => 2
      t.string :serialnum, :limit => 16, :default => 'none'
      t.string :asset_tag, :limit => 16, :default => 'none'
      t.text :description
      t.text :warranty
      t.boolean :active, :default => 1
      t.date :commissioned
      t.integer :service_level_id, :limit => 2
      t.integer :dr_method_id, :limit => 2

      t.timestamps
    end
  end
end
