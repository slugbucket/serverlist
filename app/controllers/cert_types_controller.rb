class CertTypesController < ApplicationController
  before_action :set_cert_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "app_layout"

  # GET /cert_types
  # GET /cert_types.json
  def index
    #@cert_types = CertType.all
    @cert_types = CertType.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /cert_types/1
  # GET /cert_types/1.json
  def show
  end

  # GET /cert_types/new
  def new
    @cert_type = CertType.new
    authorize! :new, @cert_type
  end

  # GET /cert_types/1/edit
  def edit
    authorize! :edit, @cert_type
  end

  # POST /cert_types
  # POST /cert_types.json
  def create
    @cert_type = CertType.new(cert_type_params)
    authorize! :create, @cert_type

    respond_to do |format|
      if @cert_type.save
        format.html { redirect_to @cert_type, notice: 'Cert type was successfully created.' }
        format.json { render :show, status: :created, location: @cert_type }
      else
        format.html { render :new }
        format.json { render json: @cert_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cert_types/1
  # PATCH/PUT /cert_types/1.json
  def update
    authorize! :update, @cert_type
    respond_to do |format|
      if @cert_type.update(cert_type_params)
        format.html { redirect_to @cert_type, notice: 'Cert type was successfully updated.' }
        format.json { render :show, status: :ok, location: @cert_type }
      else
        format.html { render :edit }
        format.json { render json: @cert_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cert_types/1
  # DELETE /cert_types/1.json
  def destroy
    authorize! :destroy, @cert_type
    @cert_type.destroy
    respond_to do |format|
      format.html { redirect_to cert_types_url, notice: 'Cert type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cert_type
      @cert_type = CertType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cert_type_params
      params.require(:cert_type).permit(:name)
    end
    def log_update
      log_msg = "id: #{@cert_type.id}\nname: #{@cert_type.name}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @cert_type.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
