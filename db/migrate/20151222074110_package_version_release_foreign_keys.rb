class PackageVersionReleaseForeignKeys < ActiveRecord::Migration
  def change
    puts "Applying package version constraint on package_version_releases"
    execute "ALTER TABLE package_version_releases
ADD CONSTRAINT package_version_fk FOREIGN KEY (package_version_id)
REFERENCES package_versions (id)
ON DELETE CASCADE
ON UPDATE CASCADE"
    puts "Applying release constraint on package_version_releases"
    execute "ALTER TABLE package_version_releases
ADD CONSTRAINT release_fk FOREIGN KEY (release_id)
REFERENCES releases (id)
ON DELETE CASCADE
ON UPDATE CASCADE"
  end
end
