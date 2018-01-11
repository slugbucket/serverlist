class OobRemoteMngmtsController < ApplicationController
  before_action :set_oob_remote_mngmt, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "host_layout"

  # GET /oob_remote_mngmts
  # GET /oob_remote_mngmts.json
  def index
    #@oob_remote_mngmts = OobRemoteMngmt.all
    @oob_remote_mngmts = OobRemoteMngmt.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /oob_remote_mngmts/1
  # GET /oob_remote_mngmts/1.json
  def show
  end

  # GET /oob_remote_mngmts/new
  def new
    @oob_remote_mngmt = OobRemoteMngmt.new
    authorize! :new, @oob_remote_mngmt
  end

  # GET /oob_remote_mngmts/1/edit
  def edit
    authorize! :edit, @oob_remote_mngmt
  end

  # POST /oob_remote_mngmts
  # POST /oob_remote_mngmts.json
  def create
    @oob_remote_mngmt = OobRemoteMngmt.new(oob_remote_mngmt_params)
    authorize! :create, @oob_remote_mngmt

    respond_to do |format|
      if @oob_remote_mngmt.save
        format.html { redirect_to @oob_remote_mngmt, notice: 'Out of band remote management was successfully created.' }
        format.json { render :show, status: :created, location: @oob_remote_mngmt }
      else
        format.html { render :new }
        format.json { render json: @oob_remote_mngmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /oob_remote_mngmts/1
  # PATCH/PUT /oob_remote_mngmts/1.json
  def update
    authorize! :update, @oob_remote_mngmt
    respond_to do |format|
      if @oob_remote_mngmt.update(oob_remote_mngmt_params)
        format.html { redirect_to @oob_remote_mngmt, notice: 'Out of band remote management was successfully updated.' }
        format.json { render :show, status: :ok, location: @oob_remote_mngmt }
      else
        format.html { render :edit }
        format.json { render json: @oob_remote_mngmt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /oob_remote_mngmts/1
  # DELETE /oob_remote_mngmts/1.json
  def destroy
    authorize! :destroy, @oob_remote_mngmt
    @oob_remote_mngmt.destroy
    respond_to do |format|
      format.html { redirect_to oob_remote_mngmts_url, notice: 'Out of band remote management was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oob_remote_mngmt
      @oob_remote_mngmt = OobRemoteMngmt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def oob_remote_mngmt_params
      params.require(:oob_remote_mngmt).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@oob_remote_mngmt.id}\nname: #{@oob_remote_mngmt.name}\ndescription: #{@oob_remote_mngmt.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @oob_remote_mngmt.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
