class PackageVersionsFk < ActiveRecord::Migration
  def change
    puts "Setting foreign key for package architecture id"
    execute "ALTER TABLE package_versions
ADD CONSTRAINT package_version_architecture_fk FOREIGN KEY (package_architecture_id)
REFERENCES package_architectures (id)
ON DELETE SET NULL
ON UPDATE CASCADE"
    puts "Setting foreign key for package id"
    execute "ALTER TABLE package_versions
ADD CONSTRAINT package_fk FOREIGN KEY (package_id)
REFERENCES packages (id)
ON DELETE CASCADE
ON UPDATE CASCADE"
  end
end
