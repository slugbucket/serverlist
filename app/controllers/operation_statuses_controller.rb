class OperationStatusesController < ApplicationController
  before_action :set_operation_status, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "operations_layout"

    # GET /operation_statuses
    # GET /operation_statuses.json
    def index
      #@operation_statuses = OperationStatus.all
      @operation_statuses = OperationStatus.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /operation_statuses/1
    # GET /operation_statuses/1.json
    def show
    end
  
    # GET /operation_statuses/new
    def new
      @operation_status = OperationStatus.new
      authorize! :new, @operation_status
    end
  
    # GET /operation_statuses/1/edit
    def edit
      authorize! :edit, @operation_status
    end
  
    # POST /operation_statuses
    # POST /operation_statuses.json
    def create
      @operation_status = OperationStatus.new(operation_status_params)
      authorize! :create, @operation_status
  
      respond_to do |format|
        if @operation_status.save
          format.html { redirect_to @operation_status, notice: 'Operation status was successfully created.' }
          format.json { render :show, status: :created, location: @operation_status }
        else
          format.html { render :new }
          format.json { render json: @operation_status.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /operation_statuses/1
    # PATCH/PUT /operation_statuses/1.json
    def update
      authorize! :update, @operation_status
      respond_to do |format|
        if @operation_status.update(operation_status_params)
          format.html { redirect_to @operation_status, notice: 'Operation status was successfully updated.' }
          format.json { render :show, status: :ok, location: @operation_status }
        else
          format.html { render :edit }
          format.json { render json: @operation_status.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /operation_statuses/1
    # DELETE /operation_statuses/1.json
    def destroy
      authorize! :destroy, @operation_status
      @operation_status.destroy
      respond_to do |format|
        format.html { redirect_to operation_statuses_url, notice: 'Operation status was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation_status
      @operation_status = OperationStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_status_params
      params.require(:operation_status).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@operation_status.id}\nname: #{@operation_status.name}\ndescription: #{@operation_status.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @operation_status.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
