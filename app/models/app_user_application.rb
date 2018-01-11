class AppUserApplication < ActiveRecord::Base
  belongs_to :app_user
  belongs_to :application
end
