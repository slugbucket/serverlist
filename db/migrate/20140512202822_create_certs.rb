class CreateCerts < ActiveRecord::Migration
  def change
    create_table :certs, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 128
      t.text :description
      t.integer :cert_type_id, :null => false, :limit => 2
      t.integer :vendor_id, :null => false, :limit => 2
      t.date :expiry
      t.integer :application_id, :limit => 2

      t.timestamps
    end
  end
end
