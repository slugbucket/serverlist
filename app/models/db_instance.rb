class DbInstance < ActiveRecord::Base
  validates :name, :db_server_id, :presence => true

  has_many :db_instance_db_names
  has_many :db_names, :through => :db_instance_db_names
  accepts_nested_attributes_for :db_names
 
  def self.getname(id)
    DbInstance.find(id).name
    rescue ActiveRecord::RecordNotFound
      "None"
  end
  def db_name_tokens=(ids)
    self.db_name_ids = ids.split(",")
  end
end
