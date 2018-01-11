class DbScheduledJobsController < ApplicationController
  before_action :set_db_scheduled_job, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

    # GET /db_scheduled_jobs
    # GET /db_scheduled_jobs.json
    def index
      #@db_scheduled_jobs = DbScheduledJob.all
      @db_scheduled_jobs = DbScheduledJob.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /db_scheduled_jobs/1
    # GET /db_scheduled_jobs/1.json
    def show
    end
  
    # GET /db_scheduled_jobs/new
    def new
      @db_scheduled_job = DbScheduledJob.new
      authorize! :new, @db_scheduled_job
    end
  
    # GET /db_scheduled_jobs/1/edit
    def edit
      authorize! :edit, @db_scheduled_job
    end
  
    # POST /db_scheduled_jobs
    # POST /db_scheduled_jobs.json
    def create
      @db_scheduled_job = DbScheduledJob.new(db_scheduled_job_params)
      authorize! :create, @db_scheduled_job
  
      respond_to do |format|
        if @db_scheduled_job.save
          format.html { redirect_to @db_scheduled_job, notice: 'Database scheduled job was successfully created.' }
          format.json { render :show, status: :created, location: @db_scheduled_job }
        else
          format.html { render :new }
          format.json { render json: @db_scheduled_job.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /db_scheduled_jobs/1
    # PATCH/PUT /db_scheduled_jobs/1.json
    def update
      authorize! :update, @db_scheduled_job
      respond_to do |format|
        if @db_scheduled_job.update(db_scheduled_job_params)
          format.html { redirect_to @db_scheduled_job, notice: 'Database scheduled job was successfully updated.' }
          format.json { render :show, status: :ok, location: @db_scheduled_job }
        else
          format.html { render :edit }
          format.json { render json: @db_scheduled_job.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /db_scheduled_jobs/1
    # DELETE /db_scheduled_jobs/1.json
    def destroy
      authorize! :destroy, @db_scheduled_job
      @db_scheduled_job.destroy
      respond_to do |format|
        format.html { redirect_to db_scheduled_jobs_url, notice: 'Database scheduled job was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_scheduled_job
      @db_scheduled_job = DbScheduledJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_scheduled_job_params
      params.require(:db_scheduled_job).permit(:name, :db_instance_db_name_id, :db_job_type_id, :db_job_host_id, :description, :db_job_status_id, :db_job_freq_id, :app_user_id, :application_id)
    end
    def log_update
      didn = DbInstanceDbName.find(@db_scheduled_job.db_instance_db_name_id).db_inst_name
      jt = DbJobType.find(@db_scheduled_job.db_job_type_id).name
      jh = DbInstance.find(@db_scheduled_job.db_job_host_id).name
      js = DbJobStatus.find(@db_scheduled_job.db_job_status_id).name
      jf = DbJobFreq.find(@db_scheduled_job.db_job_freq_id).name
      au = AppUser.find(@db_scheduled_job.app_user_id).name
      ap = Application.find(@db_scheduled_job.application_id).name
      log_msg = "id: #{@db_scheduled_job.id}\nname: #{@db_scheduled_job.name}\ndescription: #{@db_scheduled_job.description}\ndb_instance_db_name: #{didn}\ndb_job_type: #{jt}\ndb_job_host: #{jh}\ndb_job_status: #{js}\ndb_job_freq: #{jf}\napp_user: #{au}\napplication: #{ap}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_scheduled_job.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
