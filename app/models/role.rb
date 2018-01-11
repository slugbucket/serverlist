class Role < ActiveRecord::Base
  has_and_belongs_to_many :sessions, :join_table => :sessions_roles
  belongs_to :resource, :polymorphic => true

  def user_tokens=(ids)
    self.user_ids = ids
  end
end
