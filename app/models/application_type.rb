class ApplicationType < ActiveRecord::Base
  belongs_to :application

  def self.getname(id)
    ApplicationType.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
