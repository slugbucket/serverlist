class PackageVersion < ActiveRecord::Base
  has_many :package_version_releases
  has_many :releases, :through => :package_version_releases
  has_one :package

  def self.get_name(id)
    PackageVersion.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end

  # Method to get the full name of the package version
  # including the package name
  def package_version_name
    pn = Package.get_name(self.package_id)
    "#{pn}-#{self.name}"
  end
  # Class method to enable ordering by the package name rather than version name
  def self.order_by_package_name
    PackageVersion.joins(" INNER JOIN packages ON package_versions.package_id = packages.id").order("packages.name")
  end
end
