class AppUser < ActiveRecord::Base
  validates :name, :app_user_type_id, :presence => true
  has_many :app_user_types

  has_many :app_user_applications
  has_many :applications, :through => :app_user_applications

  # Instance method to return the display names of the db_instance and db_name for a
  # particular id
  def app_user_name_type
    "#{AppUser.find(id).name} - #{AppUserType.find(app_user_type_id).name}"
  end
  # Filter app user names by their first letter - used for alphabetic pagination
  #scope :by_letter, lambda { |initial| where("name LIKE ?", initial+"%") }
  # Works in ruby 1.9.2
  scope :by_letter, lambda { |initial| where("name LIKE ?", initial+"%") }
  # Works in ruby 1.9.3
  #scope :by_letter, ->(initial) {where("name LIKE \'#{initial}%\'") }
end
