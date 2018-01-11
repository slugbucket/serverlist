class Application < ActiveRecord::Base
  validates :name, :presence => true
  validates :vendor_id, :presence => true
  validates :application_type_id, :presence => true
  validates :application_status_id, :presence => true
  validates :escalation_level_id, :impact_hour_id, :impact_level_id, :presence => true

  has_one :vendor
  has_one :application_type
  has_one :application_status
  has_one :warranty_contract
  has_one :support_contact
  has_one :support_group
  has_one :dr_shutdown_stage

  has_many :application_hosts
  has_many :hosts, :through => :application_hosts #, :class_name => "Host", :foreign_key => "host_id", :conditions => "active = 1", :dependent => :destroy
  attr_reader :app_host_tokens

  has_many :app_user_applications
  has_many :app_users, :through => :app_user_applications # , :class_name => "AppUser", :foreign_key => "app_user_id", :dependent => :destroy

  has_many :application_db_instance_db_names
  has_many :db_instance_db_names, :through => :application_db_instance_db_names, :foreign_key => "db_instance_db_name_id"
  #has_many :db_names

  has_many :application_enterprise_applications
  has_many :enterprise_applications, :through => :application_enterprise_applications

  has_many :application_warranty_contracts
  has_many :warranty_contracts, :through => :application_warranty_contracts, :foreign_key => "warranty_contract_id", :primary_key => "id"
  attr_reader :warranty_contract_tokens

  has_one :escalation_level
  has_one :impact_hour
  has_many :impact_level

  def app_host_tokens=(ids)
    self.host_ids = ids.split(',')
  end

  def app_db_tokens=(ids)
    self.db_instance_db_name_ids = ids
  end

  def app_user_tokens=(ids)
    self.app_user_ids = ids
  end
  def warranty_contract_tokens=(ids)
    self.warranty_contract_ids = ids.split(',')
  end
  # Instance method to return the display names of the db_instance and db_name for a
  # particular id
  def app_name_status
    "#{Application.find(id).label} - #{ApplicationStatus.getname(application_status)}"
  end
  # Filter application names by their first letter - used for alphabetic pagination
  scope :by_letter, lambda { |initial| where("name LIKE ?", initial+"%") }
  # The following works but only for equality rather than LIKE
  #scope :by_letter, ->(initial) {where(:name =>'%') }
  #scope :by_letter, ->(initial) {where("name LIKE \'#{initial}%\'") }
end
