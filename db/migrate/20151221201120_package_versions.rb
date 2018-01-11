class PackageVersions < ActiveRecord::Migration
  def change
    create_table :package_versions, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.string :name, :null => false, :limit => 64
      t.integer :package_id, :null => false
      t.integer :package_architecture_id, :default => 1

      t.timestamps
      t.index [:name, :package_id], :unique => true, :name => 'package_version_package_id_idx'
    end
  end
end
