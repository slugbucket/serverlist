class ApplicationDbInstanceDbName < ActiveRecord::Base
  belongs_to :application
  belongs_to :db_instance_db_name
end
