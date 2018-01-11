class ServiceLevelsController < ApplicationController
  before_action :set_service_level, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "operations_layout"

    # GET /service_levels
    # GET /service_levels.json
    def index
      #@service_levels = ServiceLevel.all
      @service_levels = ServiceLevel.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /service_levels/1
    # GET /service_levels/1.json
    def show
    end
  
    # GET /service_levels/new
    def new
      @service_level = ServiceLevel.new
      authorize! :new, @service_level
    end
  
    # GET /service_levels/1/edit
    def edit
      authorize! :edit, @service_level
    end
  
    # POST /service_levels
    # POST /service_levels.json
    def create
      @service_level = ServiceLevel.new(service_level_params)
      authorize! :create, @service_level
  
      respond_to do |format|
        if @service_level.save
          format.html { redirect_to @service_level, notice: 'Service level was successfully created.' }
          format.json { render :show, status: :created, location: @service_level }
        else
          format.html { render :new }
          format.json { render json: @service_level.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /service_levels/1
    # PATCH/PUT /service_levels/1.json
    def update
      authorize! :update, @service_level
      respond_to do |format|
        if @service_level.update(service_level_params)
          format.html { redirect_to @service_level, notice: 'Service level was successfully updated.' }
          format.json { render :show, status: :ok, location: @service_level }
        else
          format.html { render :edit }
          format.json { render json: @service_level.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /service_levels/1
    # DELETE /service_levels/1.json
    def destroy
      authorize! :destroy, @service_level
      @service_level.destroy
      respond_to do |format|
        format.html { redirect_to service_levels_url, notice: 'Service level was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_level
      @service_level = ServiceLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_level_params
      params.require(:service_level).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@service_level.id}\nname: #{@service_level.name}\ndescription: #{@service_level.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @service_level.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
