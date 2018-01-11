class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "release_layout"

  # GET /packages %>
  # GET /packages.json
  def index
    #@packages = Package.all
    @packages = Package.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /packages/1
  # GET /packages/1.json
  def show
  end
  
  # GET /packages/new
  def new
    @package = Package.new
    authorize! :new, @package
  end
  
  # GET /packages/1/edit
  def edit
    authorize! :edit, @package
  end
  
  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)
    authorize! :create, @package

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package, notice: 'package was successfully created.' }
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    authorize! :update, @package
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    authorize! :destroy, @package
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@package.id}\nname: #{@package.name}\ndescription: #{@package.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @package.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end 
