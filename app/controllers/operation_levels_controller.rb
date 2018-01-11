class OperationLevelsController < ApplicationController
  before_action :set_operation_level, only: [:show, :edit, :update, :destroy]
    before_filter :authenticate_session!, :except => [:show, :index]
    after_action :log_update, only: [:create, :update, :destroy]

  layout "operations_layout"

    # GET /operation_levels
    # GET /operation_levels.json
    def index
      #@operation_levels = OperationLevel.all
      @operation_levels = OperationLevel.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /operation_levels/1
    # GET /operation_levels/1.json
    def show
    end
  
    # GET /operation_levels/new
    def new
      @operation_level = OperationLevel.new
      authorize! :new, @operation_level
    end
  
    # GET /operation_levels/1/edit
    def edit
      authorize! :edit, @operation_level
    end
  
    # POST /operation_levels
    # POST /operation_levels.json
    def create
      @operation_level = OperationLevel.new(operation_level_params)
      authorize! :create, @operation_level
  
      respond_to do |format|
        if @operation_level.save
          format.html { redirect_to @operation_level, notice: 'Operation level was successfully created.' }
          format.json { render :show, status: :created, location: @operation_level }
        else
          format.html { render :new }
          format.json { render json: @operation_level.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /operation_levels/1
    # PATCH/PUT /operation_levels/1.json
    def update
      authorize! :update, @operation_level
      respond_to do |format|
        if @operation_level.update(operation_level_params)
          format.html { redirect_to @operation_level, notice: 'Operation level was successfully updated.' }
          format.json { render :show, status: :ok, location: @operation_level }
        else
          format.html { render :edit }
          format.json { render json: @operation_level.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /operation_levels/1
    # DELETE /operation_levels/1.json
    def destroy
      authorize! :destroy, @operation_level
      @operation_level.destroy
      respond_to do |format|
        format.html { redirect_to operation_levels_url, notice: 'Operation level was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_level
      @operation_level = OperationLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_level_params
      params.require(:operation_level).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@operation_level.id}\nname: #{@operation_level.name}\ndescription: #{@operation_level.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @operation_level.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
