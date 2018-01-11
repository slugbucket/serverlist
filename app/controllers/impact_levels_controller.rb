class ImpactLevelsController < ApplicationController
  before_action :set_impact_level, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "operations_layout"

  # GET /impact_levels
  # GET /impact_levels.json
  def index
    #@impact_levels = ImpactLevel.all
    @impact_levels = ImpactLevel.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /impact_levels/1
  # GET /impact_levels/1.json
  def show
  end

  # GET /impact_levels/new
  def new
    @impact_level = ImpactLevel.new
    authorize! :new, @impact_level
  end

  # GET /impact_levels/1/edit
  def edit
    authorize! :edit, @impact_level
  end

  # POST /impact_levels
  # POST /impact_levels.json
  def create
    @impact_level = ImpactLevel.new(impact_level_params)
    authorize! :create, @impact_level

    respond_to do |format|
      if @impact_level.save
        format.html { redirect_to @impact_level, notice: 'Impact level was successfully created.' }
        format.json { render :show, status: :created, location: @impact_level }
      else
        format.html { render :new }
        format.json { render json: @impact_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /impact_levels/1
  # PATCH/PUT /impact_levels/1.json
  def update
    authorize! :update, @impact_level
    respond_to do |format|
      if @impact_level.update(impact_level_params)
        format.html { redirect_to @impact_level, notice: 'Impact level was successfully updated.' }
        format.json { render :show, status: :ok, location: @impact_level }
      else
        format.html { render :edit }
        format.json { render json: @impact_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /impact_levels/1
  # DELETE /impact_levels/1.json
  def destroy
    authorize! :destroy, @impact_level
    @impact_level.destroy
    respond_to do |format|
      format.html { redirect_to impact_levels_url, notice: 'Impact level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_impact_level
      @impact_level = ImpactLevel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def impact_level_params
      params.require(:impact_level).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@impact_level.id}\nname: #{@impact_level.name}\ndescription: #{@impact_level.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @impact_level.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
