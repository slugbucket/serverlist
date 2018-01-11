class DrShutdownStage < ActiveRecord::Base
  belongs_to :application

  def self.getname(id)
    DrShutdownStage.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
  # For presenting a long-form version of the item in drop down select lists
  def long_name
    "#{self.name} - #{self.description}"
  end
end
