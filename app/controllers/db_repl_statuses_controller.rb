class DbReplStatusesController < ApplicationController
  before_action :set_db_repl_status, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_repl_statuses
  # GET /db_repl_statuses.json
  def index
    #@db_repl_statuses = DbReplStatus.all
    @db_repl_statuses = DbReplStatus.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_repl_statuses/1
  # GET /db_repl_statuses/1.json
  def show
  end

  # GET /db_repl_statuses/new
  def new
    @db_repl_status = DbReplStatus.new
    authorize! :new, @db_repl_status
  end

  # GET /db_repl_statuses/1/edit
  def edit
    authorize! :edit, @db_repl_status
  end

  # POST /db_repl_statuses
  # POST /db_repl_statuses.json
  def create
    @db_repl_status = DbReplStatus.new(db_repl_status_params)
    authorize! :create, @db_repl_status

    respond_to do |format|
      if @db_repl_status.save
        format.html { redirect_to @db_repl_status, notice: 'Database replication status was successfully created.' }
        format.json { render :show, status: :created, location: @db_repl_status }
      else
        format.html { render :new }
        format.json { render json: @db_repl_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_repl_statuses/1
  # PATCH/PUT /db_repl_statuses/1.json
  def update
    authorize! :update, @db_repl_status
    respond_to do |format|
      if @db_repl_status.update(db_repl_status_params)
        format.html { redirect_to @db_repl_status, notice: 'Database replication status was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_repl_status }
      else
        format.html { render :edit }
        format.json { render json: @db_repl_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_repl_statuses/1
  # DELETE /db_repl_statuses/1.json
  def destroy
    authorize! :destroy, @db_repl_status
    @db_repl_status.destroy
    respond_to do |format|
      format.html { redirect_to db_repl_statuses_url, notice: 'Database replication status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_repl_status
      @db_repl_status = DbReplStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_repl_status_params
      params.require(:db_repl_status).permit(:name)
    end
    def log_update
      log_msg = "id: #{@db_repl_status.id}\nname: #{@db_repl_status.name}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_repl_status.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
