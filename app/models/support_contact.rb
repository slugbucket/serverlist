class SupportContact < ActiveRecord::Base
  belongs_to :application

  def self.getname(id)
    SupportContact.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
