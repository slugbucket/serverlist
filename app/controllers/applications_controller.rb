class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "app_layout"

  # GET /applications
  # GET /applications.json
  def index
    if(params[:q]) then
      search_condition = "%" + params[:q] + "%"
    elsif(params[:search]) then
      search_condition = "%" + params[:search] + "%"
      session[:search] = params[:search]
      session.delete :page
    elsif(session[:search])
      search_condition = "%" + session[:search] + "%"
    else
      search_condition = "%"
      session.delete :search
    end
    if(params[:page]) then
      session[:page] = params[:page]
    elsif(session[:page])
      nil
    else
      session.delete :page
    end
    @applications = Application.where("name like ?", search_condition).order(:name).paginate :page => session[:page], :per_page => 25
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new
    authorize! :new, @application
  end

  # GET /applications/1/edit
  def edit
    authorize! :edit, @application
  end

  # POST /applications
  # POST /applications.json
  def create
    authorize! :create, @application
    @application = Application.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to @application, notice: 'Application was successfully created.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    authorize! :update, @application
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to @application, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    authorize! :destroy, @application
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      params.require(:application).permit(:name, :application_type_id, :application_status_id, :vendor_id, :support_contact_id, :support_group_id, :description, :escalation_level_id, :impact_hour_id, :impact_level_id, :dr_shutdown_stage_id,   :app_host_tokens, :warranty_contract_tokens, {db_instance_db_name_ids: []}, {app_user_ids: []} )
    end
  def log_update
    at   = ApplicationType.getname(@application.application_type_id)
    as   = ApplicationStatus.getname(@application.application_status_id)
    v    = Vendor.getname(@application.vendor_id)
    sc   = SupportContact.getname(@application.support_contact_id)
    sg   = SupportGroup.getname(@application.support_group_id)
    el   = EscalationLevel.getname(@application.escalation_level_id)
    ih   = ImpactHour.getname(@application.impact_hour_id)
    il   = ImpactLevel.getname(@application.impact_level_id)
    drss = DrShutdownStage.getname(@application.dr_shutdown_stage_id)
    log_msg = "id: #{@application.id}\nname: #{@application.name}\napplication_type: #{at}\napplication_status: #{as}\nvendor: #{v}\nsupport_contact: #{sc}\nsupport_group: #{sg}\ndescription: #{@application.description}\nescalation_level: #{el}\nimpact_hour: #{ih}\nimpact_level: #{il}\ndr_shutdown_stage: #{drss}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @application.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
  end
end
