class OperatingSystemsController < ApplicationController
  before_action :set_operating_system, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "host_layout"

  # GET /operating_systems
  # GET /operating_systems.json
  def index
    #@operating_systems = OperatingSystem.all
    @operating_systems = OperatingSystem.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /operating_systems/1
  # GET /operating_systems/1.json
  def show
  end

  # GET /operating_systems/new
  def new
    @operating_system = OperatingSystem.new
    authorize! :new, @operating_system
  end

  # GET /operating_systems/1/edit
  def edit
    authorize! :edit, @operating_system
  end

  # POST /operating_systems
  # POST /operating_systems.json
  def create
    @operating_system = OperatingSystem.new(operating_system_params)
    authorize! :create, @operating_system

    respond_to do |format|
      if @operating_system.save
        format.html { redirect_to @operating_system, notice: 'Operating system was successfully created.' }
        format.json { render :show, status: :created, location: @operating_system }
      else
        format.html { render :new }
        format.json { render json: @operating_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operating_systems/1
  # PATCH/PUT /operating_systems/1.json
  def update
    authorize! :update, @operating_system
    respond_to do |format|
      if @operating_system.update(operating_system_params)
        format.html { redirect_to @operating_system, notice: 'Operating system was successfully updated.' }
        format.json { render :show, status: :ok, location: @operating_system }
      else
        format.html { render :edit }
        format.json { render json: @operating_system.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operating_systems/1
  # DELETE /operating_systems/1.json
  def destroy
    authorize! :destroy, @operating_system
    @operating_system.destroy
    respond_to do |format|
      format.html { redirect_to operating_systems_url, notice: 'Operating system was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operating_system
      @operating_system = OperatingSystem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operating_system_params
      params.require(:operating_system).permit(:name, :description, :expiry)
    end
    def log_update
      log_msg = "id: #{@operating_system.id}\nname: #{@operating_system.name}\ndescription: #{@operating_system.description}\mexpiry: #{@operating_system.expiry}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @operating_system.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
