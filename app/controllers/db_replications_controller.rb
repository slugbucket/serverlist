class DbReplicationsController < ApplicationController
  before_action :set_db_replication, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_replications
  # GET /db_replications.json
  def index
    #@db_replications = DbReplication.all
    @db_replications = DbReplication.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_replications/1
  # GET /db_replications/1.json
  def show
  end

  # GET /db_replications/new
  def new
    @db_replication = DbReplication.new
    authorize! :new, @db_replication
  end

  # GET /db_replications/1/edit
  def edit
    authorize! :edit, @db_replication
  end

  # POST /db_replications
  # POST /db_replications.json
  def create
    @db_replication = DbReplication.new(db_replication_params)
    authorize! :create, @db_replication

    respond_to do |format|
      if @db_replication.save
        format.html { redirect_to @db_replication, notice: 'Database replication was successfully created.' }
        format.json { render :show, status: :created, location: @db_replication }
      else
        format.html { render :new }
        format.json { render json: @db_replication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_replications/1
  # PATCH/PUT /db_replications/1.json
  def update
    authorize! :update, @db_replication
    respond_to do |format|
      if @db_replication.update(db_replication_params)
        format.html { redirect_to @db_replication, notice: 'Database replication was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_replication }
      else
        format.html { render :edit }
        format.json { render json: @db_replication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_replications/1
  # DELETE /db_replications/1.json
  def destroy
    authorize! :destroy, @db_replication
    @db_replication.destroy
    respond_to do |format|
      format.html { redirect_to db_replications_url, notice: 'Database replication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_replication
      @db_replication = DbReplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_replication_params
      params.require(:db_replication).permit(:name, :db_repl_type_id, :db_repl_host_id, :db_repl_src_id, :db_repl_target_id, :description, :db_repl_status_id, :db_repl_freq_id, :application_id)
    end
    def log_update
      rt = DbReplType.find(@db_replication.db_repl_type_id).name
      rh = DbInstance.find(@db_replication.db_repl_host_id).name
      src = DbInstanceDbName.find(@db_replication.db_repl_src_id).db_inst_name
      dst = DbInstanceDbName.find(@db_replication.db_repl_target_id).db_inst_name
      rs = DbReplStatus.find(@db_replication.db_repl_status_id).name
      rf = DbReplFreq.find(@db_replication.db_repl_freq_id).name
      ap = Application.find(@db_replication.application_id).name
      log_msg = "id: #{@db_replication.id}\nname: #{@db_replication.name}\ndescription: #{@db_replication.description}\ndb_repl_type: #{rt}\ndb_repl_host: #{rh}\ndb_repl_src: #{src}\ndb_repl_target: #{dst}\ndb_repl_status: #{rs}\ndb_repl_freq: #{rf}\napplication: #{ap}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_replication.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
