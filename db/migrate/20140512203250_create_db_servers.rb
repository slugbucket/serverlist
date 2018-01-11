class CreateDbServers < ActiveRecord::Migration
  def change
    create_table :db_servers, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 32
      t.text :description
      t.integer :db_cluster_id, :limit => 2

      t.timestamps
    end
  end
end
