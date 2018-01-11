class EscalationLevel < ActiveRecord::Base
  belongs_to :application

  def self.getname(id)
    EscalationLevel.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
