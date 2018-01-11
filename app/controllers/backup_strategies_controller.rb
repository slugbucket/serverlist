class BackupStrategiesController < ApplicationController
  before_action :set_backup_strategy, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "host_layout"

  # GET /backup_strategies
  # GET /backup_strategies.json
  def index
    #@backup_strategies = BackupStrategy.all
    @backup_strategies = BackupStrategy.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /backup_strategies/1
  # GET /backup_strategies/1.json
  def show
  end

  # GET /backup_strategies/new
  def new
    @backup_strategy = BackupStrategy.new
    authorize! :new, @backup_strategy
  end

  # GET /backup_strategies/1/edit
  def edit
    authorize! :edit, @backup_strategy
  end

  # POST /backup_strategies
  # POST /backup_strategies.json
  def create
    authorize! :create, @backup_strategy
    @backup_strategy = BackupStrategy.new(backup_strategy_params)

    respond_to do |format|
      if @backup_strategy.save
        format.html { redirect_to @backup_strategy, notice: 'Backup strategy was successfully created.' }
        format.json { render :show, status: :created, location: @backup_strategy }
      else
        format.html { render :new }
        format.json { render json: @backup_strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backup_strategies/1
  # PATCH/PUT /backup_strategies/1.json
  def update
    authorize! :update, @backup_strategy
    respond_to do |format|
      if @backup_strategy.update(backup_strategy_params)
        format.html { redirect_to @backup_strategy, notice: 'Backup strategy was successfully updated.' }
        format.json { render :show, status: :ok, location: @backup_strategy }
      else
        format.html { render :edit }
        format.json { render json: @backup_strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backup_strategies/1
  # DELETE /backup_strategies/1.json
  def destroy
    authorize! :dsetroy, @backup_strategy
    @backup_strategy.destroy
    respond_to do |format|
      format.html { redirect_to backup_strategies_url, notice: 'Backup strategy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_backup_strategy
      @backup_strategy = BackupStrategy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def backup_strategy_params
      params.require(:backup_strategy).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@backup_strategy.id}\nname: #{@backup_strategy.name}\ndescription: #{@backup_strategy.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @backup_strategy.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
