class DbPackagesController < ApplicationController
  before_action :set_db_package, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_packages
  # GET /db_packages.json
  def index
    #@db_packages = DbPackage.all
    @db_packages = DbPackage.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_packages/1
  # GET /db_packages/1.json
  def show
  end

  # GET /db_packages/new
  def new
    @db_package = DbPackage.new
    authorize! :new, @db_package
  end

  # GET /db_packages/1/edit
  def edit
    authorize! :edit, @db_package
  end

  # POST /db_packages
  # POST /db_packages.json
  def create
    @db_package = DbPackage.new(db_package_params)
    authorize! :create, @db_package

    respond_to do |format|
      if @db_package.save
        format.html { redirect_to @db_package, notice: 'Database package was successfully created.' }
        format.json { render :show, status: :created, location: @db_package }
      else
        format.html { render :new }
        format.json { render json: @db_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_packages/1
  # PATCH/PUT /db_packages/1.json
  def update
    authorize! :update, @db_package
    respond_to do |format|
      if @db_package.update(db_package_params)
        format.html { redirect_to @db_package, notice: 'Database package was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_package }
      else
        format.html { render :edit }
        format.json { render json: @db_package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_packages/1
  # DELETE /db_packages/1.json
  def destroy
    authorize! :destroy, @db_package
    @db_package.destroy
    respond_to do |format|
      format.html { redirect_to db_packages_url, notice: 'Database package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_package
      @db_package = DbPackage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_package_params
      params.require(:db_package).permit(:name, :description, :db_package_type_id, :db_instance_id, :db_instance_db_name_id)
    end
    def log_update
      pt = DbPackageType.find(@db_package.db_package_type_id).name
      didn = DbInstanceDbName.find(@db_package.db_instance_db_name_id).db_inst_name
      log_msg = "id: #{@db_package.id}\nname: #{@db_package.name}\ndescription: #{@db_package.description}\npackage_type: #{pt}\ndatabase_instance_database_name: #{didn}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_package.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
