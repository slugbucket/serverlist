class ModelsController < ApplicationController
  before_action :set_model, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "host_layout"

  # GET /models
  # GET /models.json
  def index
    #@models = Model.all
    @models = Model.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /models/1
  # GET /models/1.json
  def show
  end
  
  # GET /models/new
  def new
    @model = Model.new
    authorize! :new, @model
  end

  # GET /models/1/edit
  def edit
    authorize! :edit, @model
  end

  # POST /models
  # POST /models.json
  def create
    @model = Model.new(model_params)
    authorize! :create, @model

    respond_to do |format|
      if @model.save
        format.html { redirect_to @model, notice: 'Model was successfully created.' }
        format.json { render :show, status: :created, location: @model }
      else
        format.html { render :new }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /models/1
  # PATCH/PUT /models/1.json
  def update
    authorize! :update, @model
    respond_to do |format|
      if @model.update(model_params)
        format.html { redirect_to @model, notice: 'Model was successfully updated.' }
        format.json { render :show, status: :ok, location: @model }
      else
        format.html { render :edit }
        format.json { render json: @model.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.json
  def destroy
    authorize! :destroy, @model
    @model.destroy
    respond_to do |format|
      format.html { redirect_to models_url, notice: 'Model was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      params.require(:model).permit(:name, :description, :vendor_id)
    end
    def log_update
      v = Vendor.getname(@model.vendor_id)
      log_msg = "id: #{@model.id}\nname: #{@model.name}\ndescription: #{@model.description}\nvendor: #{v}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @model.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
