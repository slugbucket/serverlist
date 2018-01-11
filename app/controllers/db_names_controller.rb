class DbNamesController < ApplicationController
  before_action :set_db_name, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "database_layout"

  # GET /db_names
  # GET /db_names.json
  def index
    if(params[:search]) then
      search_condition = "%" + params[:search] + "%"
      session[:search] = params[:search]
      session.delete :page
    elsif(session[:search])
      search_condition = "%" + session[:search] + "%"
    else
      search_condition = "%"
      session.delete :search
    end
    if(params[:page]) then
      session[:page] = params[:page]
    elsif(session[:page])
     nil
     else
      session.delete :page
    end
    @db_names = DbName.where("name like ?", search_condition).order(:name).paginate :page => session[:page], :per_page => 25
  end

  # GET /db_names/1
  # GET /db_names/1.json
  def show
  end

  # GET /db_names/new
  def new
    @db_name = DbName.new
    authorize! :new, @db_name
  end

  # GET /db_names/1/edit
  def edit
    authorize! :edit, @db_name
  end

  # POST /db_names
  # POST /db_names.json
  def create
    @db_name = DbName.new(db_name_params)
    authorize! :create, @db_name

    respond_to do |format|
      if @db_name.save
        format.html { redirect_to @db_name, notice: 'Database name was successfully created.' }
        format.json { render :show, status: :created, location: @db_name }
      else
        format.html { render :new }
        format.json { render json: @db_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_names/1
  # PATCH/PUT /db_names/1.json
  def update
    authorize! :update, @db_name
    respond_to do |format|
      if @db_name.update(db_name_params)
        format.html { redirect_to @db_name, notice: 'Database name was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_name }
      else
        format.html { render :edit }
        format.json { render json: @db_name.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_names/1
  # DELETE /db_names/1.json
  def destroy
    authorize! :destroy, @db_name
    @db_name.destroy
    respond_to do |format|
      format.html { redirect_to db_names_url, notice: 'Database name was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_name
      @db_name = DbName.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_name_params
      params.require(:db_name).permit(:name, :description, :db_instances)
    end
    def log_update
      log_msg = "id: #{@db_name.id}\nname: #{@db_name.name}\ndescription: #{@db_name.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @db_name.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
