class CreateApplicationHosts < ActiveRecord::Migration
  def change
    create_table :application_hosts, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :application_id, :null => false, :limit => 2
      t.integer :host_id, :null => false, :limit => 2

      t.timestamps
    end
  end
end
