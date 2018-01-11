class DbServer < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true

  belongs_to :db_instance
  has_one :db_cluster

  has_many :db_server_hosts
  has_many :hosts, :through => :db_server_hosts
  attr_reader :host_tokens

  def host_tokens=(ids)
    self.host_ids = ids.split(',')
  end

  # Filter db servers by their first letter - used for alphabetic pagination
  # Works in ruby 1.9.2
  scope :by_letter, lambda { |initial| where("name LIKE ?", initial+"%") }
  # Works in ruby 1.9.3
  #scope :by_letter, ->(initial) {where("name LIKE \'#{initial}%\'") }
end
