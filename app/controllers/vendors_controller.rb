class VendorsController < ApplicationController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "support_layout"

    # GET /vendors
    # GET /vendors.json
    def index
      #@vendors = Vendor.all
      @vendors = Vendor.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /vendors/1
    # GET /vendors/1.json
    def show
    end
  
    # GET /vendors/new
    def new
      @vendor = Vendor.new
      authorize! :new, @vendor
    end
  
    # GET /vendors/1/edit
    def edit
      authorize! :edit, @vendor
    end
  
    # POST /vendors
    # POST /vendors.json
    def create
      @vendor = Vendor.new(vendor_params)
      authorize! :create, @vendor
  
      respond_to do |format|
        if @vendor.save
          format.html { redirect_to @vendor, notice: 'Vendor was successfully created.' }
          format.json { render :show, status: :created, location: @vendor }
        else
          format.html { render :new }
          format.json { render json: @vendor.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /vendors/1
    # PATCH/PUT /vendors/1.json
    def update
      authorize! :update, @vendor
      respond_to do |format|
        if @vendor.update(vendor_params)
          format.html { redirect_to @vendor, notice: 'Vendor was successfully updated.' }
          format.json { render :show, status: :ok, location: @vendor }
        else
          format.html { render :edit }
          format.json { render json: @vendor.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /vendors/1
    # DELETE /vendors/1.json
    def destroy
      authorize! :destroy, @vendor
      @vendor.destroy
      respond_to do |format|
        format.html { redirect_to vendors_url, notice: 'Vendor was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit(:name, :telephone, :description)
    end
  def log_update
    log_msg = "id: #{@vendor.id}\nname: #{@vendor.name}\ntelephone: #{@vendor.telephone}\ndescription: #{@vendor.description}" 
    ActivityLog.create(:item_type => controller_name.classify, :item_id => @vendor.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
   end
end
