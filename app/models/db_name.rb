class DbName < ActiveRecord::Base
  validates :name, :presence => true
  has_many :db_instance_db_names
  has_many :db_instances, :through => :db_instance_db_names
 
  def db_instances=(ids)
    self.db_instance_ids = ids
  end
  def self.getname(id)
    DbName.find(id).name
    rescue ActiveRecord::RecordNotFound
      "None"
  end
end
