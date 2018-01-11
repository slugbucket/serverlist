class PackageVersionRelease < ActiveRecord::Base
  belongs_to :package_version
  belongs_to :release
end
