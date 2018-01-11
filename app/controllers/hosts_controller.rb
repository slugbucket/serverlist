class HostsController < ApplicationController
  before_action :set_host, only: [:show, :edit, :update, :destroy]
  before_action :set_initials, only: [:index, :search]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "host_layout"

  # GET /hosts
  # GET /hosts.json
  def index
    Rails.logger.debug("DEBUG: Index filtering by location #{session[:host_location]}")
    if(params[:q]) then
      search_condition = "%" + params[:q] + "%"
    elsif session[:search] then
      search_condition = "%" + session[:search] + "%"
      session.delete :hosts_page
    elsif(session[:search])
      search_condition = "%" + session[:search] + "%"
    else
      search_condition = "%"
    end
    if(params[:page]) then
      session[:hosts_page] = params[:page]
    else
      session[:hosts_page] = 1
    end
    Rails.logger.debug("DEBUG: index filtering by name, #{search_condition}.")
    # Don't paginate results for a tokeInput search
    
    if session[:host_location]
      Rails.logger.debug("DEBUG: Filtering by name #{search_condition} and loction #{session[:host_location]}.")
    #  @hosts = Host.where("name like ? AND active = 1", search_condition).order(:name).paginate :page => session[:hosts_page], :per_page => 25
      @hosts = Host.hosts_in_location(session[:host_location], search_condition).order("name "+" "+sort_direction).paginate :page => session[:host_page], :per_page => 25
    else
      Rails.logger.debug("DEBUG: Filtering by name #{search_condition}.")
      @hosts = Host.where("name like ?", search_condition).order(:name).order("name "+" "+sort_direction).paginate :page => session[:host_page], :per_page => 25
    end
  end

  # GET /hosts/1
  # GET /hosts/1.json
  def show
  end

  # GET /hosts/new
  def new
    @host = Host.new
    authorize! :new, @host
  end

  # GET /hosts/1/edit
  def edit
    authorize! :edit, @host
  end

  # POST /hosts
  # POST /hosts.json
  def create
    @host = Host.new(host_params)
    authorize! :create, @host

    respond_to do |format|
      if @host.save
        format.html { redirect_to @host, notice: 'Host was successfully created.' }
        format.json { render :show, status: :created, location: @host }
      else
        format.html { render :new }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hosts/1
  # PATCH/PUT /hosts/1.json
  def update
    authorize! :update, @host
    respond_to do |format|
      if @host.update(host_params)
        format.html { redirect_to @host, notice: 'Host was successfully updated.' }
        format.json { render :show, status: :ok, location: @host }
      else
        format.html { render :edit }
        format.json { render json: @host.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    authorize! :destroy, @host
    @host.destroy
    respond_to do |format|
      format.html { redirect_to hosts_url, notice: 'Host was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_host
      @host = Host.find(params[:id])
    end

    def set_initials
      # Check for when a subdept selection request comes in
      # This is ugly and clashes with the 
      #session[:host_location] ||= (params[:location].to_i > 0) ? params[:location].to_i : nil 
      

      # Running a search clears the current session data
      if params[:search] then
        session.delete :host_page
        session.delete :host_sortcol
        session.delete :host_letter
        session[:search] ||= params[:search]
      end
      #@first_letters = Phone.select("DISTINCT LOWER(SUBSTRING(phones.surname, 1, 1)) AS surname").order("surname").collect{|fl| "#{fl.surname}"}
      session.delete :host_page if params[:page]
      session[:host_page] ||= params[:page]
      session.delete :host_location if params[:location]
      session[:host_location] ||= params[:location].to_i if params[:location].to_i > 0
      if session[:host_letter] != params[:q] && params[:q] then
        session[:host_page] = 1
      end

      # An additional check for clearing the search term
      session.delete :search if params[:search] && params[:search] != session[:search]
      session.delete :search if session[:search].nil? || session[:search].empty?
      session.delete :host_location if params[:search] && params[:search].empty?
      session[:search] ||= params[:search]
      session[:host_page] ||= (params[:page] && params[:page].to_i.is_a?(Integer)) ? params[:page].to_i : 1
      #session.delete :phone_letter if params[:q]
      #session[:phone_letter] ||= ('a'..'z').include?(params[:q]) ? params[:q] : ''
      session.delete :host_letter if params[:q]
      session[:host_letter] ||= ('a'..'z').include?(params[:q]) ? params[:q] : ''
      session.delete :host_sortcol if params[:sort]
      session[:host_sortcol] ||= sort_column
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def host_params
      params.require(:host).permit(:name, :runbook_alias, :location_id, :primary_use, :ad_domain_id, :oob_remote_mngmt_id, :operating_system_id, :model_id, :serialnum, :description, :warranty, :active, :commissioned, :service_level_id, :dr_method_id)
    end
    def sort_column
      %w[name].include?(params[:sort]) ? params[:sort] : "name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
    def log_update
      l   = Location.get_name(@host.location_id)
      ad  = AdDomain.get_name(@host.ad_domain_id)
      oob = OobRemoteMngmt.get_name(@host.oob_remote_mngmt_id)
      os  = OperatingSystem.get_name(@host.operating_system_id)
      m   = Model.get_name(@host.model_id)
      sl  = ServiceLevel.get_name(@host.service_level_id)
      dr  = DrMethod.get_name(@host.dr_method_id)
      log_msg = "id: #{@host.id}\nname: #{@host.name}\ndescription: #{@host.description}\nlocation: #{l}\nprimary_use: #{@host.primary_use}\nad_domain: #{ad}\noob_remote: #{oob}\noperating_system: #{os}\nwarranty: #{@host.warranty}\nactive: #{@host.active}\ncommissioned: #{@host.commissioned}\nservice_level: #{sl}\ndr_method: #{dr}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @host.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
