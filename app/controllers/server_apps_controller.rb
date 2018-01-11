class ServerAppsController < ApplicationController
  before_action :set_server_app, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "app_layout"
  
  # GET /server_apps
  # GET /server_apps.json
  def index
    #@server_apps = ServerApp.all
    @server_apps = ServerApp.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /server_apps/1
  # GET /server_apps/1.json
  def show
  end

  # GET /server_apps/new
  def new
    @server_app = ServerApp.new
    authorize! :new, @server_app
  end

  # GET /server_apps/1/edit
  def edit
    authorize! :edit, @server_app
  end

  # POST /server_apps
  # POST /server_apps.json
  def create
    @server_app = ServerApp.new(server_app_params)
    authorize! :create, @server_app

    respond_to do |format|
      if @server_app.save
        format.html { redirect_to @server_app, notice: 'Server app was successfully created.' }
        format.json { render :show, status: :created, location: @server_app }
      else
        format.html { render :new }
        format.json { render json: @server_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /server_apps/1
  # PATCH/PUT /server_apps/1.json
  def update
    authorize! :update, @server_app
    respond_to do |format|
      if @server_app.update(server_app_params)
        format.html { redirect_to @server_app, notice: 'Server app was successfully updated.' }
        format.json { render :show, status: :ok, location: @server_app }
      else
        format.html { render :edit }
        format.json { render json: @server_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /server_apps/1
  # DELETE /server_apps/1.json
  def destroy
    authorize! :destroy, @server_app
    @server_app.destroy
    respond_to do |format|
      format.html { redirect_to server_apps_url, notice: 'Server app was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_server_app
      @server_app = ServerApp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def server_app_params
      params.require(:server_app).permit(:name, :description, :vendor_id, :warranty_contract_id)
    end
    def log_update
      v = Vendor.getname(@server_app.id)
      wc = WarrantyContract.getname(@server_app.warranty_contract_id)
      log_msg = "id: #{@server_app.id}\nname: #{@server_app.name}\ndescription: #{@server_app.description}\nVendor: #{v}\nWarrantyContract: #{wc}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @server_app.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
