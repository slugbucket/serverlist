class WarrantyContractsController < ApplicationController
  before_action :set_warranty_contract, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "support_layout"

    # GET /warranty_contracts
    # GET /warranty_contracts.json
    def index
      #@warranty_contracts = WarrantyContract.all
      if(params[:q]) then
        @warranty_contracts = WarrantyContract.where("name like ?", params[:q] + "%").order("name asc").paginate :page => params[:page], :per_page => 25
      else
        @warranty_contracts = WarrantyContract.order("name asc").paginate :page => params[:page], :per_page => 25
      end
    end
  
    # GET /warranty_contracts/1
    # GET /warranty_contracts/1.json
    def show
    end
  
    # GET /warranty_contracts/new
    def new
      @warranty_contract = WarrantyContract.new
      authorize! :new, @warranty_contract
    end
  
    # GET /warranty_contracts/1/edit
    def edit
      authorize! :edit, @warranty_contract
    end
  
    # POST /warranty_contracts
    # POST /warranty_contracts.json
    def create
      @warranty_contract = WarrantyContract.new(warranty_contract_params)
      authorize! :create, @warranty_contract
  
      respond_to do |format|
        if @warranty_contract.save
          format.html { redirect_to @warranty_contract, notice: 'Warranty contract was successfully created.' }
          format.json { render :show, status: :created, location: @warranty_contract }
        else
          format.html { render :new }
          format.json { render json: @warranty_contract.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /warranty_contracts/1
    # PATCH/PUT /warranty_contracts/1.json
    def update
      authorize! :update, @warranty_contract
      respond_to do |format|
        if @warranty_contract.update(warranty_contract_params)
          format.html { redirect_to @warranty_contract, notice: 'Warranty contract was successfully updated.' }
          format.json { render :show, status: :ok, location: @warranty_contract }
        else
          format.html { render :edit }
          format.json { render json: @warranty_contract.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /warranty_contracts/1
    # DELETE /warranty_contracts/1.json
    def destroy
      authorize! :destroy, @warranty_contract
      @warranty_contract.destroy
      respond_to do |format|
        format.html { redirect_to warranty_contracts_url, notice: 'Warranty contract was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warranty_contract
      @warranty_contract = WarrantyContract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warranty_contract_params
      params.require(:warranty_contract).permit(:name, :description, :vendor_id, :warranty_type_id, :expiry)
    end
    def log_update
      v  = Vendor.getname(@warranty_contract.id)
      wt = WarrantyType.getname(@warranty_contract.warranty_type_id)
      log_msg = "id: #{@warranty_contract.id}\nname: #{@warranty_contract.name}\ndescription: #{@warranty_contract.description}\nVendor: #{v}\nWarranty_type: #{wt}\nexpiry: #{@warranty_contract.expiry}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @warranty_contract.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
