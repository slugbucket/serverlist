class PackageArchitecturesController < ApplicationController
  before_action :set_package_architecture, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "release_layout"

  
  # GET /package_architectures %>
  # GET /package_architectures.json
  def index
    #@package_architectures = PackageArchitecture.all
    @package_architectures = PackageArchitecture.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /package_architectures/1
  # GET /package_architectures/1.json
  def show
  end
  
  # GET /package_architectures/new
  def new
    @package_architecture = PackageArchitecture.new
    authorize! :new, @package_architecture
  end
  
  # GET /package_architectures/1/edit
  def edit
    authorize! :edit, @package_architecture
  end
  
  # POST /package_architectures
  # POST /package_architectures.json
  def create
    @package_architecture = PackageArchitecture.new(package_architecture_params)
    authorize! :create, @package_architecture

    respond_to do |format|
      if @package_architecture.save
        format.html { redirect_to @package_architecture, notice: 'PackageArchitecture was successfully created.' }
        format.json { render :show, status: :created, location: @package_architecture }
      else
        format.html { render :new }
        format.json { render json: @package_architecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /package_architectures/1
  # PATCH/PUT /package_architectures/1.json
  def update
    authorize! :update, @package_architecture
    respond_to do |format|
      if @package_architecture.update(package_architecture_params)
        format.html { redirect_to @package_architecture, notice: 'package_architecture was successfully updated.' }
        format.json { render :show, status: :ok, location: @package_architecture }
      else
        format.html { render :edit }
        format.json { render json: @package_architecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /package_architectures/1
  # DELETE /package_architectures/1.json
  def destroy
    authorize! :destroy, @package_architecture
    @package_architecture.destroy
    respond_to do |format|
      format.html { redirect_to package_architectures_url, notice: 'package_architectures was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package_architecture
      @package_architecture = PackageArchitecture.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def package_architecture_params
      params.require(:package_architecture).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@package_architecture.id}\nname: #{@package_architecture.name}\ndescription: #{@package_architecture.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @package_architecture.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end 
