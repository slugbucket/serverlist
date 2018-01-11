class DbInstanceDbName < ActiveRecord::Base
  belongs_to :db_instance
  belongs_to :db_name
  belongs_to :db_replication

  has_and_belongs_to_many :applications, :join_table => :application_db_instance_db_names
  #has_many :application_db_instance_db_names
  #has_many :applications, :through => :application_db_instance_db_names, :foreign_key => "application_id"

  has_many :db_repl_src_didn

  #attr_accessible :db_instance_id, :db_name_id

  # Instance method to return the id of a db_instance/db_name combination record
  def db_inst_id
      "#{id}"
  end

  def get_db_instance_id
    "#{db_instance_id}"
  end
  # Instance method to return the display names of the db_instance and db_name for a
  # particular id
  def db_inst_name
    "#{DbInstance.getname(db_instance_id)} - #{DbName.getname(db_name_id)}"
  end
  scope :order_by_inst_name, lambda {  select("db_instance_db_names.id, db_instance_id, db_name_id").joins(:db_instance).order("db_instances.name") }
  #scope :by_letter, lambda { |initial| where("name LIKE ?", initial+"%") }
end
