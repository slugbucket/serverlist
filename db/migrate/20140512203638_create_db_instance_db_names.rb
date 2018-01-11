class CreateDbInstanceDbNames < ActiveRecord::Migration
  def change
    create_table :db_instance_db_names, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :db_instance_id, :null => false, :limit => 2
      t.integer :db_name_id, :null => false, :limit => 2

      t.timestamps
    end
  end
end
