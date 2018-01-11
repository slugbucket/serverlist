class Host < ActiveRecord::Base
  validates :name, :oob_remote_mngmt_id, :location_id, :presence => true

  has_many :db_server_hosts
  has_many :db_servers, :through => :db_server_hosts, :foreign_key => :db_server_id

  has_many :locations
  has_many :models
  has_many :oob_remote_mngmts
  has_many :ad_domains
  has_many :os_tables
  has_many :backup_strategies

  # Warranty contracts
  has_many :host_warranty_contracts
  has_many :warranty_contracts, :through => :host_warranty_contracts, :foreign_key => "warranty_contract_id", :primary_key => "id"

  # Mapping to applications
  has_many :application_hosts
  has_many :applications, :through => :application_hosts, :class_name => "Application", :foreign_key => "application_id"

  # backup strategies
  has_many :backup_strategy_hosts
  has_many :backup_strategies, :through => :backup_strategy_hosts, :foreign_key => "backup_strategy_id", :primary_key => "id"

  def warranty_contract_tokens=(ids)
    self.warranty_contract_ids = ids.split(',')
  end

  # Backup tokens
  def backup_strategy_tokens=(ids)
    self.backup_strategy_ids = ids
  end

  # Filter host names by their first letter - used for alphabetic pagination
  #scope :by_letter, lambda { |initial| where("name LIKE ?", initial+"%") }
  # Works in ruby 1.9.2
  scope :by_letter, lambda { |initial| where("name LIKE ?", initial+"%") }
  # Works in ruby 1.9.3
  #name#scope :by_letter, ->(initial) {where("name LIKE \'#{initial}%\'") }
  def self.hosts_in_location(loc, name)
    Host.where(" location_id = #{loc} AND name LIKE '#{name}' ")
  end
end
