class DbJobTypesController < ApplicationController
  before_action :set_db_job_type, only: [:show, :edit, :update, :destroy]

  # GET /db_job_types
  # GET /db_job_types.json
  def index
    @db_job_types = DbJobType.all
  end

  # GET /db_job_types/1
  # GET /db_job_types/1.json
  def show
  end

  # GET /db_job_types/new
  def new
    @db_job_type = DbJobType.new
  end

  # GET /db_job_types/1/edit
  def edit
  end

  # POST /db_job_types
  # POST /db_job_types.json
  def create
    @db_job_type = DbJobType.new(db_job_type_params)

    respond_to do |format|
      if @db_job_type.save
        format.html { redirect_to @db_job_type, notice: 'Db job type was successfully created.' }
        format.json { render :show, status: :created, location: @db_job_type }
      else
        format.html { render :new }
        format.json { render json: @db_job_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /db_job_types/1
  # PATCH/PUT /db_job_types/1.json
  def update
    respond_to do |format|
      if @db_job_type.update(db_job_type_params)
        format.html { redirect_to @db_job_type, notice: 'Db job type was successfully updated.' }
        format.json { render :show, status: :ok, location: @db_job_type }
      else
        format.html { render :edit }
        format.json { render json: @db_job_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /db_job_types/1
  # DELETE /db_job_types/1.json
  def destroy
    @db_job_type.destroy
    respond_to do |format|
      format.html { redirect_to db_job_types_url, notice: 'Db job type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_db_job_type
      @db_job_type = DbJobType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def db_job_type_params
      params.require(:db_job_type).permit(:name)
    end
end
