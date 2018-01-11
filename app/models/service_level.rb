class ServiceLevel < ActiveRecord::Base
  belongs_to :host
  validates :name, :presence => true, :uniqueness => true

  def self.get_name(id)
    ServiceLevel.find(id).name
    rescue ActiveRecord::RecordNotFound
      return "None"
  end
end
