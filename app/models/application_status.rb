class ApplicationStatus < ActiveRecord::Base
  belongs_to :application

  def self.getname(id)
    ApplicationStatus.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
