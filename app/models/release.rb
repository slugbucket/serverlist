class Release < ActiveRecord::Base
  has_many :package_version_releases
  has_many :package_versions, :through => :package_version_releases
  validates :name, :presence => true, :uniqueness => true

  # Extract the package version id values submitted. We don't need to split
  # them when they are already split having come from a multiple select field
  # unlike the text field token-select which is a comma-separated string which
  # does need to be split.
  #def package_version_ids=(ids)
  #  #ids.reject!(&:blank)
  #  Rails.logger.debug("DEBUG: model: Release params are now #{ids}.")
  #  Rails.logger.debug("DEBUG: model: Updating package_version_ids from  #{self.package_version_ids}.")
  #  self.package_version_tokens = ids.split(",")
  #end
  #attr_reader :package_version_tokens

  def self.get_name(id)
    Release.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
