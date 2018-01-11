class DbReplTypesController < ApplicationController
  before_action :set_db_repl_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_repl_types
  # GET /db_repl_types.json
  def index
    #@db_repl_types = DbReplType.all
    @db_repl_types = DbReplType.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_repl_types/1
  # GET /db_repl_types/1.json
  def show
  end

  # GET /db_repl_types/new
  def new
    @db_repl_type = DbReplType.new
    authorize! :new, @db_repl_type
  end

  # GET /db_repl_types/1/edit
  def edit
    authorize! :edit, @db_repl_type
  end

  # POST /db_repl_types
  # POST /db_repl_types.json
  def create
    @db_repl_type = DbReplType.new(db_repl_type_params)
    authorize! :create, @db_repl_type

    respond_to do |format|
      if @db_repl_type.save
        format.html { redirect_to @db_repl_type, notice: 'Database replication type was successfully created.' }
        format.json { render :show, status: :created, location: @db_repl_type }
      else
        format.html { render :new }
        format.json { render json: @db_repl_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_repl_types/1
  # PATCH/PUT /db_repl_types/1.json
  def update
    authorize! :update, @db_repl_type
    respond_to do |format|
      if @db_repl_type.update(db_repl_type_params)
        format.html { redirect_to @db_repl_type, notice: 'Database replication type was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_repl_type }
      else
        format.html { render :edit }
        format.json { render json: @db_repl_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_repl_types/1
  # DELETE /db_repl_types/1.json
  def destroy
    authorize! :destroy, @db_repl_type
    @db_repl_type.destroy
    respond_to do |format|
      format.html { redirect_to db_repl_types_url, notice: 'Database replication type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_repl_type
      @db_repl_type = DbReplType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_repl_type_params
      params.require(:db_repl_type).permit(:name)
    end
    def log_update
      log_msg = "id: #{@db_repl_type.id}\nname: #{@db_repl_type.name}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_repl_type.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
