class ImpactHoursController < ApplicationController
  before_action :set_impact_hour, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "operations_layout"

    # GET /impact_hours
    # GET /impact_hours.json
    def index
      #@impact_hours = ImpactHour.all
      @impact_hours = ImpactHour.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /impact_hours/1
    # GET /impact_hours/1.json
    def show
    end
  
    # GET /impact_hours/new
    def new
      @impact_hour = ImpactHour.new
      authorize! :new, @impact_hour
    end
  
    # GET /impact_hours/1/edit
    def edit
      authorize! :edit, @impact_hour
    end
  
    # POST /impact_hours
    # POST /impact_hours.json
    def create
      @impact_hour = ImpactHour.new(impact_hour_params)
      authorize! :create, @impact_hour
  
      respond_to do |format|
        if @impact_hour.save
          format.html { redirect_to @impact_hour, notice: 'Impact hour was successfully created.' }
          format.json { render :show, status: :created, location: @impact_hour }
        else
          format.html { render :new }
          format.json { render json: @impact_hour.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /impact_hours/1
    # PATCH/PUT /impact_hours/1.json
    def update
      authorize! :update, @impact_hour
      respond_to do |format|
        if @impact_hour.update(impact_hour_params)
          format.html { redirect_to @impact_hour, notice: 'Impact hour was successfully updated.' }
          format.json { render :show, status: :ok, location: @impact_hour }
        else
          format.html { render :edit }
          format.json { render json: @impact_hour.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /impact_hours/1
    # DELETE /impact_hours/1.json
    def destroy
      authorize! :destroy, @impact_hour
      @impact_hour.destroy
      respond_to do |format|
        format.html { redirect_to impact_hours_url, notice: 'Impact hour was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_impact_hour
      @impact_hour = ImpactHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def impact_hour_params
      params.require(:impact_hour).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@impact_hour.id}\nname: #{@impact_hour.name}\ndescription: #{@impact_hour.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @impact_hour.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
