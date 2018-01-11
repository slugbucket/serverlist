class EnterpriseApplicationsController < ApplicationController
  before_action :set_enterprise_application, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "app_layout"

  # GET /enterprise_applications
  # GET /enterprise_applications.json
  def index
    #@enterprise_applications = EnterpriseApplication.all
    @enterprise_applications = EnterpriseApplication.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /enterprise_applications/1
  # GET /enterprise_applications/1.json
  def show
  end

  # GET /enterprise_applications/new
  def new
    @enterprise_application = EnterpriseApplication.new
    authorize! :new, @enterprise_application
  end

  # GET /enterprise_applications/1/edit
  def edit
    authorize! :edit, @enterprise_application
  end

  # POST /enterprise_applications
  # POST /enterprise_applications.json
  def create
    @enterprise_application = EnterpriseApplication.new(enterprise_application_params)
    authorize! :create, @enterprise_application

    respond_to do |format|
      if @enterprise_application.save
        format.html { redirect_to @enterprise_application, notice: 'Enterprise application was successfully created.' }
        format.json { render :show, status: :created, location: @enterprise_application }
      else
        format.html { render :new }
        format.json { render json: @enterprise_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enterprise_applications/1
  # PATCH/PUT /enterprise_applications/1.json
  def update
    authorize! :update, @enterprise_application
    respond_to do |format|
      if @enterprise_application.update(enterprise_application_params)
        format.html { redirect_to @enterprise_application, notice: 'Enterprise application was successfully updated.' }
        format.json { render :show, status: :ok, location: @enterprise_application }
      else
        format.html { render :edit }
        format.json { render json: @enterprise_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enterprise_applications/1
  # DELETE /enterprise_applications/1.json
  def destroy
    authorize! :destroy, @enterprise_application
    @enterprise_application.destroy
    respond_to do |format|
      format.html { redirect_to enterprise_applications_url, notice: 'Enterprise application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_enterprise_application
      @enterprise_application = EnterpriseApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enterprise_application_params
      params.require(:enterprise_application).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@enterprise_application.id}\nname: #{@enterprise_application.name}\ndescription: #{@enterprise_application.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @enterprise_application.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
