class AppUserType < ActiveRecord::Base
  belongs_to :app_user
  validates :name, :presence => true

  def self.get_name(id)
    "#{AppUserType.find(id).name}"
  rescue ActiveRecord::RecordNptFound
    "None"
  end
end
