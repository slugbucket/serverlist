class PackageVersionReleasePrimaryKey < ActiveRecord::Migration
  def change
    puts "Creating composite primary key for package_version_releases"
    execute "ALTER TABLE package_version_releases
    ADD PRIMARY KEY (package_version_id, release_id)"
  end
end
