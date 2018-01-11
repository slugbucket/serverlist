class CreateDbServerHosts < ActiveRecord::Migration
  def change
    create_table :db_server_hosts, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :db_server_id, :null => false, :limit => 4, :default => 0
      t.integer :host_id, :null => false, :limit => 4, :default => 0
    end
  end
end
