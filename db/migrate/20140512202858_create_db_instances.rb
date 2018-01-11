class CreateDbInstances < ActiveRecord::Migration
  def change
    create_table :db_instances, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.integer :db_server_id, :null => false, :limit => 2
      t.integer :server_app_id, :null => false, :limit => 2
      t.text :description

      t.timestamps
    end
  end
end
