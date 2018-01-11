class PackageVersionsController < ApplicationController
  before_action :set_package_version, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "release_layout"

  # GET /package_versions %>
  # GET /package_versions.json
  def index
    #@package_versions = PackageVersion.all
    @package_versions = PackageVersion.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /package_versions/1
  # GET /package_versions/1.json
  def show
  end
  
  # GET /package_versions/new
  def new
    @package_version = PackageVersion.new
    authorize! :new, @package_version
  end
  
  # GET /package_versions/1/edit
  def edit
    authorize! :edit, @package_version
  end
  
  # POST /package_versions
  # POST /package_versions.json
  def create
    @package_version = PackageVersion.new(package_version_params)
    authorize! :create, @package_version

    respond_to do |format|
      if @package_version.save
        format.html { redirect_to @package_version, notice: 'package_version was successfully created.' }
        format.json { render :show, status: :created, location: @package_version }
      else
        format.html { render :new }
        format.json { render json: @package_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /package_versions/1
  # PATCH/PUT /package_versions/1.json
  def update
    authorize! :update, @package_version
    respond_to do |format|
      if @package_version.update(package_version_params)
        format.html { redirect_to @package_version, notice: 'package_version was successfully updated.' }
        format.json { render :show, status: :ok, location: @package_version }
      else
        format.html { render :edit }
        format.json { render json: @package_version.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /package_versions/1
  # DELETE /package_versions/1.json
  def destroy
    authorize! :destroy, @package_version
    @package_version.destroy
    respond_to do |format|
      format.html { redirect_to package_versions_url, notice: 'package_versions was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package_version
      @package_version = PackageVersion.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def package_version_params
      params.require(:package_version).permit(:name, :package_id, :package_architecture_id)
    end
    def log_update
      pkg = Package.find(@package_version.package_id).name
      pka = PackageArchitecture.find(@package_version.package_architecture_id).name
      log_msg = "id: #{@package_version.id}\nname: #{@package_version.name}\npackage: #{pkg}\npackage architecture: #{pka}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @package_version.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end 
