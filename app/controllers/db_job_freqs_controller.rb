class DbJobFreqsController < ApplicationController
  before_action :set_db_job_freq, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_job_freqs
  # GET /db_job_freqs.json
  def index
    #@db_job_freqs = DbJobFreq.all
    @db_job_freqs = DbJobFreq.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_job_freqs/1
  # GET /db_job_freqs/1.json
  def show
  end

  # GET /db_job_freqs/new
  def new
    @db_job_freq = DbJobFreq.new
    authorize! :new, @db_job_freq
  end

  # GET /db_job_freqs/1/edit
  def edit
    authorize! :edit, @db_job_freq
  end

  # POST /db_job_freqs
  # POST /db_job_freqs.json
  def create
    @db_job_freq = DbJobFreq.new(db_job_freq_params)
    authorize! :create, @db_job_freq

    respond_to do |format|
      if @db_job_freq.save
        format.html { redirect_to @db_job_freq, notice: 'Db job freq was successfully created.' }
        format.json { render :show, status: :created, location: @db_job_freq }
      else
        format.html { render :new }
        format.json { render json: @db_job_freq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_job_freqs/1
  # PATCH/PUT /db_job_freqs/1.json
  def update
    authorize! :update, @db_job_freq
    respond_to do |format|
      if @db_job_freq.update(db_job_freq_params)
        format.html { redirect_to @db_job_freq, notice: 'Db job freq was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_job_freq }
      else
        format.html { render :edit }
        format.json { render json: @db_job_freq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_job_freqs/1
  # DELETE /db_job_freqs/1.json
  def destroy
    authorize! :destroy, @db_job_freq
    @db_job_freq.destroy
    respond_to do |format|
      format.html { redirect_to db_job_freqs_url, notice: 'Db job freq was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_job_freq
      @db_job_freq = DbJobFreq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_job_freq_params
      params.require(:db_job_freq).permit(:name)
    end
    def log_update
      log_msg = "id: #{@db_job_freq.id}\nname: #{@db_job_freq.name}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_job_freq.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end