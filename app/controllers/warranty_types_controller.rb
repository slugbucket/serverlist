class WarrantyTypesController < ApplicationController
  before_action :set_warranty_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "support_layout"

    # GET /warranty_types
    # GET /warranty_types.json
    def index
      #@warranty_types = WarrantyType.all
      @warranty_types = WarrantyType.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /warranty_types/1
    # GET /warranty_types/1.json
    def show
    end
  
    # GET /warranty_types/new
    def new
      @warranty_type = WarrantyType.new
      authorize! :new, @warranty_type
    end
  
    # GET /warranty_types/1/edit
    def edit
      authorize! :edit, @warranty_type
    end
  
    # POST /warranty_types
    # POST /warranty_types.json
    def create
      @warranty_type = WarrantyType.new(warranty_type_params)
      authorize! :create, @warranty_type
  
      respond_to do |format|
        if @warranty_type.save
          format.html { redirect_to @warranty_type, notice: 'Warranty type was successfully created.' }
          format.json { render :show, status: :created, location: @warranty_type }
        else
          format.html { render :new }
          format.json { render json: @warranty_type.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /warranty_types/1
    # PATCH/PUT /warranty_types/1.json
    def update
      authorize! :update, @warranty_type
      respond_to do |format|
        if @warranty_type.update(warranty_type_params)
          format.html { redirect_to @warranty_type, notice: 'Warranty type was successfully updated.' }
          format.json { render :show, status: :ok, location: @warranty_type }
        else
          format.html { render :edit }
          format.json { render json: @warranty_type.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /warranty_types/1
    # DELETE /warranty_types/1.json
    def destroy
      authorize! :destroy, @warranty_type
      @warranty_type.destroy
      respond_to do |format|
        format.html { redirect_to warranty_types_url, notice: 'Warranty type was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warranty_type
      @warranty_type = WarrantyType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warranty_type_params
      params.require(:warranty_type).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@warranty_type.id}\nname: #{@warranty_type.name}\ndescription: #{@warranty_type.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @warranty_type.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
