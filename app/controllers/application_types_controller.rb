class ApplicationTypesController < ApplicationController
  before_action :set_application_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]
    
  layout "app_layout"

  # GET /application_types
  # GET /application_types.json
  def index
    #@application_types = ApplicationType.all
    @application_types = ApplicationType.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /application_types/1
  # GET /application_types/1.json
  def show
  end

  # GET /application_types/new
  def new
    @application_type = ApplicationType.new
    authorize! :new, @application_type
  end

  # GET /application_types/1/edit
  def edit
    authorize! :edit, @application_type
  end

  # POST /application_types
  # POST /application_types.json
  def create
    @application_type = ApplicationType.new(application_type_params)
    authorize! :create, @application_type

    respond_to do |format|
      if @application_type.save
        format.html { redirect_to @application_type, notice: 'Application type was successfully created.' }
        format.json { render :show, status: :created, location: @application_type }
      else
        format.html { render :new }
        format.json { render json: @application_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /application_types/1
  # PATCH/PUT /application_types/1.json
  def update
    authorize! :update, @application_type
    respond_to do |format|
      if @application_type.update(application_type_params)
        format.html { redirect_to @application_type, notice: 'Application type was successfully updated.' }
        format.json { render :show, status: :ok, location: @application_type }
      else
        format.html { render :edit }
        format.json { render json: @application_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_types/1
  # DELETE /application_types/1.json
  def destroy
    authorize! :destroy, @application_type
    @application_type.destroy
    respond_to do |format|
      format.html { redirect_to application_types_url, notice: 'Application type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application_type
      @application_type = ApplicationType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_type_params
      params.require(:application_type).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@application_type.id}\nname: #{@application_type.name}\ndescription: #{@application_type.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @application_type.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
