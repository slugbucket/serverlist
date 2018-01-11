class ImpactLevel < ActiveRecord::Base
  belongs_to :application

  def self.getname(id)
    ImpactLevel.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
