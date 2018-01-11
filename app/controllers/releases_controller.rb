class ReleasesController < ApplicationController
  before_action :set_release, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "release_layout"

  # GET /releases %>
  # GET /releases.json
  def index
    #@releases = Release.all
    @releases = Release.order("name asc").paginate :page => params[:page], :per_page => 25
  end
  
  # GET /releases/1
  # GET /releases/1.json
  def show
  end
  
  # GET /releases/new
  def new
    @release = Release.new
    authorize! :new, @release
  end
  
  # GET /releases/1/edit
  def edit
    authorize! :edit, @release
  end
  
  # POST /releases
  # POST /releases.json
  def create
    @release = Release.new(release_params)
    authorize! :create, @release

    respond_to do |format|
      if @release.save
        format.html { redirect_to @release, notice: '@release was successfully created.' }
        format.json { render :show, status: :created, location: @release }
      else
        format.html { render :new }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /releases/1
  # PATCH/PUT /releases/1.json
  def update
    authorize! :update, @release

    respond_to do |format|
      if @release.update(release_params)
        format.html { redirect_to @release, notice: 'release was successfully updated.' }
        format.json { render :show, status: :ok, location: @release }
      else
        format.html { render :edit }
        format.json { render json: @release.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /releases/1
  # DELETE /releases/1.json
  def destroy
    authorize! :destroy, @release
    @release.destroy
    respond_to do |format|
      format.html { redirect_to releases_url, notice: 'releases was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_release
      @release = Release.find(params[:id])
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def release_params
      params.require(:release).permit(:name, :description, {:package_version_ids => []})
    end
    def log_update
      log_msg = "id: #{@release.id}\nname: #{@release.name}\ndescription: #{@release.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @release.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
  end 
