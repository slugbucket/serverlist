class DbServersController < ApplicationController
  before_action :set_db_server, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_servers
  # GET /db_servers.json
  def index
    #@db_servers = DbServer.all
    @db_servers = DbServer.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_servers/1
  # GET /db_servers/1.json
  def show
  end

  # GET /db_servers/new
  def new
    @db_server = DbServer.new
    authorize! :new, @db_server
  end

  # GET /db_servers/1/edit
  def edit
    authorize! :edit, @db_server
  end

  # POST /db_servers
  # POST /db_servers.json
  def create
    @db_server = DbServer.new(db_server_params)
    authorize! :create, @db_server

    respond_to do |format|
      if @db_server.save
        format.html { redirect_to @db_server, notice: 'Database servers was successfully created.' }
        format.json { render :show, status: :created, location: @db_server }
      else
        format.html { render :new }
        format.json { render json: @db_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_servers/1
  # PATCH/PUT /db_servers/1.json
  def update
    authorize! :update, @db_server
    respond_to do |format|
      if @db_server.update(db_server_params)
        format.html { redirect_to @db_server, notice: 'Database servers was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_server }
      else
        format.html { render :edit }
        format.json { render json: @db_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_servers/1
  # DELETE /db_servers/1.json
  def destroy
    authorize! :destroy, @db_server
    @db_server.destroy
    respond_to do |format|
      format.html { redirect_to db_servers_url, notice: 'Database servers was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_server
      @db_server = DbServer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_server_params
      params.require(:db_server).permit(:name, :description, :db_cluster_id, :host_tokens)
    end
    def log_update
      dc = DbCluster.getname(@db_server.db_cluster_id)
      log_msg = "id: #{@db_server.id}\nname: #{@db_server.name}\ndescription: #{@db_server.description}\nCluster: #{dc}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_server.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
