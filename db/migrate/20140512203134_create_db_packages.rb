class CreateDbPackages < ActiveRecord::Migration
  def change
    create_table :db_packages, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.text :description
      t.integer :db_package_type_id, :null => false, :limit => 2
      t.integer :db_instance_id, :null => false, :limit => 2
      t.integer :db_instance_db_name_id, :null => false, :limit => 2

      t.timestamps
    end
  end
end
