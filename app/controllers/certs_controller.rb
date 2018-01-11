class CertsController < ApplicationController
  before_action :set_cert, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "app_layout"

  # GET /certs
  # GET /certs.json
  def index
    #@certs = Cert.all
    @certs = Cert.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /certs/1
  # GET /certs/1.json
  def show
  end

  # GET /certs/new
  def new
    @cert = Cert.new
    authorize! :new, @cert
  end

  # GET /certs/1/edit
  def edit
    authorize! :edit, @cert
  end

  # POST /certs
  # POST /certs.json
  def create
    @cert = Cert.new(cert_params)
    authorize! :create, @cert

    respond_to do |format|
      if @cert.save
        format.html { redirect_to @cert, notice: 'Cert was successfully created.' }
        format.json { render :show, status: :created, location: @cert }
      else
        format.html { render :new }
        format.json { render json: @cert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certs/1
  # PATCH/PUT /certs/1.json
  def update
    authorize! :create, @cert
    respond_to do |format|
      if @cert.update(cert_params)
        format.html { redirect_to @cert, notice: 'Cert was successfully updated.' }
        format.json { render :show, status: :ok, location: @cert }
      else
        format.html { render :edit }
        format.json { render json: @cert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certs/1
  # DELETE /certs/1.json
  def destroy
    authorize! :destroy, @cert
    @cert.destroy
    respond_to do |format|
      format.html { redirect_to certs_url, notice: 'Cert was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cert
      @cert = Cert.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cert_params
      params.require(:cert).permit(:name, :description, :cert_type_id, :vendor_id, :expiry, :application_id)
    end
    def log_update
      ct = CertType.find(@cert.cert_type_id).name
      v  = (@cert.vendor_id) ? Vendor.find(@cert.vendor_id).name : "None"
      a = (@cert.application_id) ? Application.find(@cert.application_id).name : "None"
      log_msg = "id: #{@cert.id}\nname: #{@cert.name}\ndescription: #{@cert.description}\ncert_type: #{ct}\nvendor: #{v}\nexpiry: #{@cert.expiry}\nApplication: #{a}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @cert.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
