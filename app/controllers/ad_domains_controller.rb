class AdDomainsController < ApplicationController
  before_action :set_ad_domain, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "host_layout"

  # GET /ad_domains
  # GET /ad_domains.json
  def index
    #@ad_domains = AdDomain.all
    @ad_domains = AdDomain.order("name asc").paginate :page => params[:page], :per_page => 25
  end

  # GET /ad_domains/1
  # GET /ad_domains/1.json
  def show
  end

  # GET /ad_domains/new
  def new
    @ad_domain = AdDomain.new
    authorize! :new, @ad_domain
  end

  # GET /ad_domains/1/edit
  def edit
    authorize! :edit, @ad_domain
  end

  # POST /ad_domains
  # POST /ad_domains.json
  def create
    @ad_domain = AdDomain.new(ad_domain_params)
    #authorize! :create, @ad_domain

    respond_to do |format|
      if @ad_domain.save
        format.html { redirect_to @ad_domain, notice: 'Active Directory domain was successfully created.' }
        format.json { render :show, status: :created, location: @ad_domain }
      else
        format.html { render :new }
        format.json { render json: @ad_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ad_domains/1
  # PATCH/PUT /ad_domains/1.json
  def update
    authorize! :update, @ad_domain
    respond_to do |format|
      if @ad_domain.update(ad_domain_params)
        format.html { redirect_to @ad_domain, notice: 'Active Directory domain was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad_domain }
      else
        format.html { render :edit }
        format.json { render json: @ad_domain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_domains/1
  # DELETE /ad_domains/1.json
  def destroy
    authorize! :destroy, @ad_domain
    @ad_domain.destroy
    respond_to do |format|
      format.html { redirect_to ad_domains_url, notice: 'Active Directory domain was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad_domain
      @ad_domain = AdDomain.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_domain_params
      params.require(:ad_domain).permit(:name, :description, :active)
    end
    def log_update
      log_msg = "id: #{@ad_domain.id}\nname: #{@ad_domain.name}\ndescription: #{@ad_domain.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @ad_domain.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
