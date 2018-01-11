class EscalationLevelsController < ApplicationController
  before_action :set_escalation_level, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "operations_layout"

    # GET /escalation_levels
    # GET /escalation_levels.json
    def index
      #@escalation_levels = EscalationLevel.all
      @escalation_levels = EscalationLevel.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /escalation_levels/1
    # GET /escalation_levels/1.json
    def show
    end
  
    # GET /escalation_levels/new
    def new
      @escalation_level = EscalationLevel.new
      authorize! :new, @escalation_level
    end
  
    # GET /escalation_levels/1/edit
    def edit
      authorize! :edit, @escalation_level
    end
  
    # POST /escalation_levels
    # POST /escalation_levels.json
    def create
      @escalation_level = EscalationLevel.new(escalation_level_params)
      authorize! :create, @escalation_level
  
      respond_to do |format|
        if @escalation_level.save
          format.html { redirect_to @escalation_level, notice: 'Escalation level was successfully created.' }
          format.json { render :show, status: :created, location: @escalation_level }
        else
          format.html { render :new }
          format.json { render json: @escalation_level.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /escalation_levels/1
    # PATCH/PUT /escalation_levels/1.json
    def update
      authorize! :update, @escalation_level
      respond_to do |format|
        if @escalation_level.update(escalation_level_params)
          format.html { redirect_to @escalation_level, notice: 'Escalation level was successfully updated.' }
          format.json { render :show, status: :ok, location: @escalation_level }
        else
          format.html { render :edit }
          format.json { render json: @escalation_level.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /escalation_levels/1
    # DELETE /escalation_levels/1.json
    def destroy
      authorize! :destroy, @escalation_level
      @escalation_level.destroy
      respond_to do |format|
        format.html { redirect_to escalation_levels_url, notice: 'Escalation level was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_escalation_level
      @escalation_level = EscalationLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def escalation_level_params
      params.require(:escalation_level).permit(:name)
    end
    def log_update
      log_msg = "id: #{@escalation_level.id}\nname: #{@escalation_level.name}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @escalation_level.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
