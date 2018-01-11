class SupportContactsController < ApplicationController
  before_action :set_support_contact, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_session!, :except => [:show, :index]
  after_action :log_update, only: [:create, :update, :destroy]

  layout "support_layout"

    # GET /support_contacts
    # GET /support_contacts.json
    def index
      #@support_contacts = SupportContact.all
      @support_contacts = SupportContact.order("name asc").paginate :page => params[:page], :per_page => 25
    end
  
    # GET /support_contacts/1
    # GET /support_contacts/1.json
    def show
    end
  
    # GET /support_contacts/new
    def new
      @support_contact = SupportContact.new
      authorize! :new, @support_contact
    end
  
    # GET /support_contacts/1/edit
    def edit
      authorize! :edit, @support_contact
    end
  
    # POST /support_contacts
    # POST /support_contacts.json
    def create
      @support_contact = SupportContact.new(support_contact_params)
      authorize! :create, @support_contact
  
      respond_to do |format|
        if @support_contact.save
          format.html { redirect_to @support_contact, notice: 'Support contact was successfully created.' }
          format.json { render :show, status: :created, location: @support_contact }
        else
          format.html { render :new }
          format.json { render json: @support_contact.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /support_contacts/1
    # PATCH/PUT /support_contacts/1.json
    def update
      authorize! :update, @support_contact
      respond_to do |format|
        if @support_contact.update(support_contact_params)
          format.html { redirect_to @support_contact, notice: 'Support contact was successfully updated.' }
          format.json { render :show, status: :ok, location: @support_contact }
        else
          format.html { render :edit }
          format.json { render json: @support_contact.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /support_contacts/1
    # DELETE /support_contacts/1.json
    def destroy
      authorize! :destroy, @support_contact
      @support_contact.destroy
      respond_to do |format|
        format.html { redirect_to support_contacts_url, notice: 'Support contact was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_support_contact
      @support_contact = SupportContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def support_contact_params
      params.require(:support_contact).permit(:name, :email_addr, :telephone)
    end
    def log_update
      log_msg = "id: #{@support_contact.id}\nname: #{@support_contact.name}\nemail_addr: #{@support_contact.email_addr}\ntelephone: #{@support_contact.telephone}}" 
      ActivityLog.create(:item_type => controller_name.classify, :item_id => @support_contact.id, :act_action => action_name, :updated_by => current_session.username, :activity => log_msg, :act_tstamp => Time.now)
    end
end
