class CreateHostPackageVersions < ActiveRecord::Migration
  def change
    create_table :host_package_versions, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :host_id, :null => false
      t.integer :package_version_id, :null => false
      t.index [:host_id, :package_version_id], :unique => true, :name => 'host_package_version_idx'
    end
  end
end
