class PackageArchitecture < ActiveRecord::Base
  belongs_to :package_version
  validates :name, :presence => true, :uniqueness => true

  def self.get_name(id)
    PackageArchitecture.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
