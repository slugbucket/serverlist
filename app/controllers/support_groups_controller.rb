class SupportGroupsController < ApplicationController
  before_action :set_support_group, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "support_layout"

    # GET /support_groups
    # GET /support_groups.json
    def index
      #@support_groups = SupportGroup.all
      @support_groups = SupportGroup.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /support_groups/1
    # GET /support_groups/1.json
    def show
    end
  
    # GET /support_groups/new
    def new
      @support_group = SupportGroup.new
      authorize! :new, @support_group
    end
  
    # GET /support_groups/1/edit
    def edit
      authorize! :edit, @support_group
    end
  
    # POST /support_groups
    # POST /support_groups.json
    def create
      @support_group = SupportGroup.new(support_group_params)
      authorize! :create, @support_group
  
      respond_to do |format|
        if @support_group.save
          format.html { redirect_to @support_group, notice: 'Support group was successfully created.' }
          format.json { render :show, status: :created, location: @support_group }
        else
          format.html { render :new }
          format.json { render json: @support_group.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /support_groups/1
    # PATCH/PUT /support_groups/1.json
    def update
      authorize! :update, @support_group
      respond_to do |format|
        if @support_group.update(support_group_params)
          format.html { redirect_to @support_group, notice: 'Support group was successfully updated.' }
          format.json { render :show, status: :ok, location: @support_group }
        else
          format.html { render :edit }
          format.json { render json: @support_group.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /support_groups/1
    # DELETE /support_groups/1.json
    def destroy
      authorize! :destroy, @support_group
      @support_group.destroy
      respond_to do |format|
        format.html { redirect_to support_groups_url, notice: 'Support group was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_support_group
      @support_group = SupportGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def support_group_params
      params.require(:support_group).permit(:name, :description)
    end
    def log_update
      log_msg = "id: #{@support_group.id}\nname: #{@support_group.name}\ndescription: #{@support_group.description}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @support_group.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
