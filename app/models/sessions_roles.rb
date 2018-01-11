class SessionsRoles < ActiveRecord::Base
  belongs_to :session
  belongs_to :role
end
