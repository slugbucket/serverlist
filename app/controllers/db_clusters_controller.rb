class DbClustersController < ApplicationController
  before_action :set_db_cluster, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_clusters
  # GET /db_clusters.json
  def index
    #@db_clusters = DbCluster.all
    @db_clusters = DbCluster.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_clusters/1
  # GET /db_clusters/1.json
  def show
  end

  # GET /db_clusters/new
  def new
    @db_cluster = DbCluster.new
    authorize! :new, @db_cluster
  end

  # GET /db_clusters/1/edit
  def edit
    authorize! :edit, @db_cluster
  end

  # POST /db_clusters
  # POST /db_clusters.json
  def create
    @db_cluster = DbCluster.new(db_cluster_params)
    authorize! :create, @db_cluster

    respond_to do |format|
      if @db_cluster.save
        format.html { redirect_to @db_cluster, notice: 'Database cluster was successfully created.' }
        format.json { render :show, status: :created, location: @db_cluster }
      else
        format.html { render :new }
        format.json { render json: @db_cluster.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_clusters/1
  # PATCH/PUT /db_clusters/1.json
  def update
    authorize! :update, @db_cluster
    respond_to do |format|
      if @db_cluster.update(db_cluster_params)
        format.html { redirect_to @db_cluster, notice: 'Database cluster was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_cluster }
      else
        format.html { render :edit }
        format.json { render json: @db_cluster.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_clusters/1
  # DELETE /db_clusters/1.json
  def destroy
    authorize! :destroy, @db_cluster
    @db_cluster.destroy
    respond_to do |format|
      format.html { redirect_to db_clusters_url, notice: 'Database cluster was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_cluster
      @db_cluster = DbCluster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_cluster_params
      params.require(:db_cluster).permit(:name)
    end
    def log_update
      log_msg = "id: #{@db_cluster.id}\nname: #{@db_cluster.name}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_cluster.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
