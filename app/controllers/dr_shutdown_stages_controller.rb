class DrShutdownStagesController < ApplicationController
  before_action :set_dr_shutdown_stage, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "operations_layout"
  
  # GET /dr_shutdown_stages
  # GET /dr_shutdown_stages.json
  def index
    #@dr_shutdown_stages = DrShutdownStage.all
    @dr_shutdown_stages = DrShutdownStage.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /dr_shutdown_stages/1
  # GET /dr_shutdown_stages/1.json
  def show
  end

  # GET /dr_shutdown_stages/new
  def new
    @dr_shutdown_stage = DrShutdownStage.new
    authorize! :new, @dr_shutdown_stage
  end

  # GET /dr_shutdown_stages/1/edit
  def edit
    authorize! :edit, @dr_shutdown_stage
  end

  # POST /dr_shutdown_stages
  # POST /dr_shutdown_stages.json
  def create
    @dr_shutdown_stage = DrShutdownStage.new(dr_shutdown_stage_params)
    authorize! :create, @dr_shutdown_stage

    respond_to do |format|
      if @dr_shutdown_stage.save
        format.html { redirect_to @dr_shutdown_stage, notice: 'Disaster recovery shutdown stages was successfully created.' }
        format.json { render :show, status: :created, location: @dr_shutdown_stage }
      else
        format.html { render :new }
        format.json { render json: @dr_shutdown_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dr_shutdown_stages/1
  # PATCH/PUT /dr_shutdown_stages/1.json
  def update
    authorize! :update, @dr_shutdown_stage
    respond_to do |format|
      if @dr_shutdown_stage.update(dr_shutdown_stage_params)
        format.html { redirect_to @dr_shutdown_stage, notice: 'Disaster recovery shutdown stages was successfully updated.' }
        format.json { render :show, status: :ok, location: @dr_shutdown_stage }
      else
        format.html { render :edit }
        format.json { render json: @dr_shutdown_stage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dr_shutdown_stages/1
  # DELETE /dr_shutdown_stages/1.json
  def destroy
    authorize! :destroy, @dr_shutdown_stage
    @dr_shutdown_stage.destroy
    respond_to do |format|
      format.html { redirect_to dr_shutdown_stages_url, notice: 'Disaster recovery shutdown stages was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dr_shutdown_stage
      @dr_shutdown_stage = DrShutdownStage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dr_shutdown_stage_params
      params.require(:dr_shutdown_stage).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@dr_shutdown_stage.id}\nname: #{@dr_shutdown_stage.name}\ndescription: #{@dr_shutdown_stage.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @dr_shutdown_stage.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
