class DbCluster < ActiveRecord::Base
  belongs_to :db_server

  def self.getname(id)
    DbCluster.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end