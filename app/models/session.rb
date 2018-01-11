class Session < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => :sessions_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :ldap_authenticatable, :rememberable, :trackable, :authentication_keys => [:username]
    
    # Use the following to extract additional attributes
    #before_save :get_ldap_email
  
    #def get_ldap_email
    #  self.email = Devise::LDAP::Adapter.get_ldap_param(self.username,"mail")
    #end
  
    # Replace with a validation of my own
    validates :username, :presence => true
  
    def self.find_for_authentication(conditions)
      conditions = ["username = ?", conditions[authentication_keys.first]]
      # raise StandardError, conditions.inspect
      super
    end
    def create  
      @session_session = SessionSession.new(params[:session_session])  
      if @session_session.save  
        flash[:notice] = "Login successful!"  
        redirect_to session_path  
      else  
        respond_to do |wants|  
          wants.html { render :new }  
          wants.js # create.js.erb  
        end  
      end  
    end
    def current_user
      true
    end
    def destroy  
      reset_session  
      flash[:notice] = "Logout successful!"  
      redirect_to session_path   
    end
end
