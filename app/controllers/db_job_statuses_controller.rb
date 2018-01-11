class DbJobStatusesController < ApplicationController
  before_action :set_db_job_status, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_job_statuses
  # GET /db_job_statuses.json
  def index
    #@db_job_statuses = DbJobStatus.all
    @db_job_statuses = DbJobStatus.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_job_statuses/1
  # GET /db_job_statuses/1.json
  def show
  end

  # GET /db_job_statuses/new
  def new
    @db_job_status = DbJobStatus.new
    authorize! :new, @db_job_status
  end

  # GET /db_job_statuses/1/edit
  def edit
    authorize! :edit, @db_job_status
  end

  # POST /db_job_statuses
  # POST /db_job_statuses.json
  def create
    @db_job_status = DbJobStatus.new(db_job_status_params)
    authorize! :create, @db_job_status

    respond_to do |format|
      if @db_job_status.save
        format.html { redirect_to @db_job_status, notice: 'Db job status was successfully created.' }
        format.json { render :show, status: :created, location: @db_job_status }
      else
        format.html { render :new }
        format.json { render json: @db_job_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_job_statuses/1
  # PATCH/PUT /db_job_statuses/1.json
  def update
    authorize! :update, @db_job_status
    respond_to do |format|
      if @db_job_status.update(db_job_status_params)
        format.html { redirect_to @db_job_status, notice: 'Db job status was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_job_status }
      else
        format.html { render :edit }
        format.json { render json: @db_job_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_job_statuses/1
  # DELETE /db_job_statuses/1.json
  def destroy
    authorize! :destroy, @db_job_status
    @db_job_status.destroy
    respond_to do |format|
      format.html { redirect_to db_job_statuses_url, notice: 'Db job status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_job_status
      @db_job_status = DbJobStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_job_status_params
      params.require(:db_job_status).permit(:name)
    end
  def log_update
        log_msg = "id: #{@db_job_status.id}\nname: #{@db_job_status.name}" 
        ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_job_status.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
      end
end
