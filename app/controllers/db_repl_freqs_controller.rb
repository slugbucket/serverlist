class DbReplFreqsController < ApplicationController
  before_action :set_db_repl_freq, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_repl_freqs
  # GET /db_repl_freqs.json
  def index
    #@db_repl_freqs = DbReplFreq.all
    @db_repl_freqs = DbReplFreq.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /db_repl_freqs/1
  # GET /db_repl_freqs/1.json
  def show
  end

  # GET /db_repl_freqs/new
  def new
    @db_repl_freq = DbReplFreq.new
    authorize! :new, @db_repl_freq
  end

  # GET /db_repl_freqs/1/edit
  def edit
    authorize! :edit, @db_repl_freq
  end

  # POST /db_repl_freqs
  # POST /db_repl_freqs.json
  def create
    @db_repl_freq = DbReplFreq.new(db_repl_freq_params)
    authorize! :create, @db_repl_freq

    respond_to do |format|
      if @db_repl_freq.save
        format.html { redirect_to @db_repl_freq, notice: 'Database replication frequency was successfully created.' }
        format.json { render :show, status: :created, location: @db_repl_freq }
      else
        format.html { render :new }
        format.json { render json: @db_repl_freq.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_repl_freqs/1
  # PATCH/PUT /db_repl_freqs/1.json
  def update
    authorize! :update, @db_repl_freq
    respond_to do |format|
      if @db_repl_freq.update(db_repl_freq_params)
        format.html { redirect_to @db_repl_freq, notice: 'Database replication frequency was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_repl_freq }
      else
        format.html { render :edit }
        format.json { render json: @db_repl_freq.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_repl_freqs/1
  # DELETE /db_repl_freqs/1.json
  def destroy
    authorize! :destroy, @db_repl_freq
    @db_repl_freq.destroy
    respond_to do |format|
      format.html { redirect_to db_repl_freqs_url, notice: 'Database replication frequency was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_repl_freq
      @db_repl_freq = DbReplFreq.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_repl_freq_params
      params.require(:db_repl_freq).permit(:name)
    end
    def log_update
      log_msg = "id: #{@db_repl_freq.id}\nname: #{@db_repl_freq.name}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_repl_freq.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
