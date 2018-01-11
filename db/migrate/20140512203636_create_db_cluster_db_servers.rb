class CreateDbClusterDbServers < ActiveRecord::Migration
  def change
    create_table :db_cluster_db_servers, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :db_cluster_id, :null => false, :limit => 2
      t.integer :db_server_id, :null => false, :limit => 2
    end
  end
end
