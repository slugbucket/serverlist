class SupportGroup < ActiveRecord::Base
  belongs_to :application

  def self.getname(id)
    SupportGroup.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
