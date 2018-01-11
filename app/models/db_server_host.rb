class DbServerHost < ActiveRecord::Base
  belongs_to :db_server
  belongs_to :host
end