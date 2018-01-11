class ImpactHour < ActiveRecord::Base
  belongs_to :application

  def self.getname(id)
    ImpactHour.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
