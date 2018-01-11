class DbPackageTypesController < ApplicationController
  before_action :set_db_package_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_package_types %>
  # GET /db_package_types.json
  def index
    #@db_package_types = DbPackageType.all
    @db_package_types = DbPackageType.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /db_package_types/1
  # GET /db_package_types/1.json
  def show
  end
  
  # GET /db_package_types/new
  def new
    @db_package_type = DbPackageType.new
    authorize! :new, @db_package_types
  end
  
  # GET /db_package_types/1/edit
  def edit
    authorize! :edit, @db_package_type
  end
  
  # POST /db_package_types
  # POST /db_package_types.json
  def create
    @db_package_type = DbPackageType.new(db_package_type_params)
    authorize! :create, @db_package_type

    respond_to do |format|
      if @db_package_type.save
        format.html { redirect_to @db_package_type, notice: 'db_package_type was successfully created.' }
        format.json { render :show, status: :created, location: @db_package_type }
      else
        format.html { render :new }
        format.json { render json: @db_package_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_package_types/1
  # PATCH/PUT /db_package_types/1.json
  def update
    authorize! :update, @db_package_type
    respond_to do |format|
      if @db_package_type.update(db_package_type_params)
        format.html { redirect_to @db_package_type, notice: 'db_package_type was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_package_type }
      else
        format.html { render :edit }
        format.json { render json: @db_package_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_package_types/1
  # DELETE /db_package_types/1.json
  def destroy
    authorize! :destroy, @db_package_type
    @db_package_type.destroy
    respond_to do |format|
      format.html { redirect_to db_package_types_url, notice: 'db_package_type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_package_type
      @db_package_type = DbPackageType.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def db_package_type_params
      params.require(:db_package_type).permit(:name)
    end
    def log_update
      log_msg = "id: #{@db_package_type.id}\nname: #{@db_package_type.name}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_package_type.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end