class PackageVersionReleases < ActiveRecord::Migration
  def change
    create_table :package_version_releases, :id => false, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.integer :release_id, :null => false
      t.integer :package_version_id, :null => false
      t.index [:release_id, :package_version_id], :unique => true, :name => 'package_version_release_idx'
    end
  end
end
