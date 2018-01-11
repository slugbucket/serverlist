class SessionsController < Devise::SessionsController
  before_filter :log_logout, :only => :destroy  #add this at the top with the other filters
  after_filter :log_failed_login, :only => [:new, :create]

  def create
    super
    username = params[:session]["username"]
    log_msg = "Successful login for #{username}"
    ActivityLog.create(:item_type => controller_name.classify, :item_id => 0, :act_action => action_name, :updated_by => params[:session]["username"], :activity => log_msg, :act_tstamp => Time.now)
    Rails.logger.debug "\n***\nSuccessful login with username : #{params[:authenticity_token]}\n***\n"
  end

  private
  def log_failed_login
    Rails.logger.debug "\n***\nFailed login with username : #{request.parameters["username"]}\n***\n" if failed_login?
  end 

  def failed_login?
    (options = env["warden.options"]) && options[:action] == "unauthenticated"
  end

  def log_logout
    log_msg = "Logging out : #{current_session.username}"
    #Rails.logger.debug log_msg
    ActivityLog.create(:item_type => controller_name.classify, :item_id => 0, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end