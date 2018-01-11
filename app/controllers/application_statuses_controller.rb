class ApplicationStatusesController < ApplicationController
  before_action :set_application_status, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]
    
  layout "app_layout"

  # GET /application_statuses
  # GET /application_statuses.json
  def index
    #@application_statuses = ApplicationStatus.all
    @application_statuses = ApplicationStatus.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /application_statuses/1
  # GET /application_statuses/1.json
  def show
  end

  # GET /application_statuses/new
  def new
    @application_status = ApplicationStatus.new
    authorize! :new, @application_status
  end

  # GET /application_statuses/1/edit
  def edit
    authorize! :edit, @application_status
  end

  # POST /application_statuses
  # POST /application_statuses.json
  def create
    @application_status = ApplicationStatus.new(application_status_params)
    authorize! :create, @application_status

    respond_to do |format|
      if @application_status.save
        format.html { redirect_to @application_status, notice: 'Application status was successfully created.' }
        format.json { render :show, status: :created, location: @application_status }
      else
        format.html { render :new }
        format.json { render json: @application_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /application_statuses/1
  # PATCH/PUT /application_statuses/1.json
  def update
    authorize! :update, @application_status
    respond_to do |format|
      if @application_status.update(application_status_params)
        format.html { redirect_to @application_status, notice: 'Application status was successfully updated.' }
        format.json { render :show, status: :ok, location: @application_status }
      else
        format.html { render :edit }
        format.json { render json: @application_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_statuses/1
  # DELETE /application_statuses/1.json
  def destroy
    authorize! :destroy, @application_status
    @application_status.destroy
    respond_to do |format|
      format.html { redirect_to application_statuses_url, notice: 'Application status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application_status
      @application_status = ApplicationStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_status_params
      params.require(:application_status).permit(:name)
    end
    def log_update
      log_msg = "id: #{@application_status.id}\nname: #{@application_status.name}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @application_status.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
