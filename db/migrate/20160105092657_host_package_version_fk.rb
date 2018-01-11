class HostPackageVersionFk < ActiveRecord::Migration
  def change
    puts "Setting foreign key for host id"
    execute "ALTER TABLE host_package_versions
ADD CONSTRAINT host_fk FOREIGN KEY (host_id)
REFERENCES hosts (id)
ON DELETE CASCADE
ON UPDATE CASCADE"
    execute "ALTER TABLE host_package_versions
ADD CONSTRAINT host_package_version_fk FOREIGN KEY (package_version_id)
REFERENCES package_versions (id)
ON DELETE CASCADE
ON UPDATE CASCADE;"
  end
end
