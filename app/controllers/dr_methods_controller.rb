class DrMethodsController < ApplicationController
  before_action :set_dr_method, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "host_layout"

  # GET /dr_methods
  # GET /dr_methods.json
  def index
    #@dr_methods = DrMethod.all
    @dr_methods = DrMethod.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /dr_methods/1
  # GET /dr_methods/1.json
  def show
  end

  # GET /dr_methods/new
  def new
    @dr_method = DrMethod.new
    authorize! :new, @dr_method
  end

  # GET /dr_methods/1/edit
  def edit
    authorize! :edit, @dr_method
  end

  # POST /dr_methods
  # POST /dr_methods.json
  def create
    @dr_method = DrMethod.new(dr_method_params)
    authorize! :create, @dr_method

    respond_to do |format|
      if @dr_method.save
        format.html { redirect_to @dr_method, notice: 'Disaster recover methods was successfully created.' }
        format.json { render :show, status: :created, location: @dr_method }
      else
        format.html { render :new }
        format.json { render json: @dr_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dr_methods/1
  # PATCH/PUT /dr_methods/1.json
  def update
    authorize! :update, @dr_method
    respond_to do |format|
      if @dr_method.update(dr_method_params)
        format.html { redirect_to @dr_method, notice: 'Disaster recover methods was successfully updated.' }
        format.json { render :show, status: :ok, location: @dr_method }
      else
        format.html { render :edit }
        format.json { render json: @dr_method.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dr_methods/1
  # DELETE /dr_methods/1.json
  def destroy
    authorize! :destroy, @dr_method
    @dr_method.destroy
    respond_to do |format|
      format.html { redirect_to dr_methods_url, notice: 'Disaster recover methods was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dr_method
      @dr_method = DrMethod.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dr_method_params
      params.require(:dr_method).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@dr_method.id}\nname: #{@dr_method.name}\ndescription: #{@dr_method.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @dr_method.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end