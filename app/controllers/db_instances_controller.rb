class DbInstancesController < ApplicationController
  before_action :set_db_instance, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_instances
  # GET /db_instances.json
  def index
    #@db_instances = DbInstance.all
    @db_instances = DbInstance.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_instances/1
  # GET /db_instances/1.json
   def show
  end

  # GET /db_instances/new
  def new
    @db_instance = DbInstance.new
    authorize! :new, @db_instance
  end

  # GET /db_instances/1/edit
  def edit
    authorize! :edit, @db_instance
  end

  # POST /db_instances
  # POST /db_instances.json
  def create
    @db_instance = DbInstance.new(db_instance_params)
    authorize! :create, @db_instance

    respond_to do |format|
      if @db_instance.save
        format.html { redirect_to @db_instance, notice: 'Database instance was successfully created.' }
        format.json { render :show, status: :created, location: @db_instance }
      else
        format.html { render :new }
        format.json { render json: @db_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_instances/1
  # PATCH/PUT /db_instances/1.json
  def update
    authorize! :update, @db_instance
    respond_to do |format|
      if @db_instance.update(db_instance_params)
        format.html { redirect_to @db_instance, notice: 'Database instance was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_instance }
      else
        format.html { render :edit }
        format.json { render json: @db_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_instances/1
  # DELETE /db_instances/1.json
  def destroy
    authorize! :destroy, @db_instance
    @db_instance.destroy
    respond_to do |format|
      format.html { redirect_to db_instances_url, notice: 'Database instance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_instance
      @db_instance = DbInstance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_instance_params
      params.require(:db_instance).permit(:name, :db_server_id, :server_app_id, :description)
    end
    def log_update
      ds = DbServer.find(@db_instance.db_server_id).name
      sa = ServerApp.find(@db_instance.server_app_id).name
      log_msg = "id: #{@db_instance.id}\nname: #{@db_instance.name}\ndescription: #{@db_instance.description}\ndb_server: #{ds}\nserver_app: #{sa}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_instance.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
