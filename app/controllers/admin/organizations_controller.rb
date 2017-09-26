class Admin::OrganizationsController < ApplicationController
  include FlashMessages
  include AuthenticateUser

  before_action :logged_in_user
  before_action :soadmin_user
  before_action :set_organization, only: [:destroy, :show, :edit, :update]

  # GET /admin/organizations
  def index
    @organizations = Organization.all
  end

  # GET /admin/organizations/new
  def new
    @organization = Organization.new
  end

  # POST /admin/organizations
  def create
    @organization = Organization.new(organization_params)
    if @organization.save
      redirect_to @organization, notice: 'Organization was successfully created.'
    else
      render :new
    end
  end

  # GET /admin/organizations/1
  def show
  end

  # GET /admin/organizations/1/edit
  def edit
  end

  # PATCH/PUT /admin/organizations/1
  def update
    if @organization.update(organization_params)
      redirect_to [:admin, @organization], notice: 'Organization was successfully updated.'
    else
      render :edit
    end
  end

    # DELETE /admin/organizations/1
  def destroy
    @organization.destroy
    redirect_to admin_organizations_url, notice: 'Organization was successfully destroyed.'
  end

  # POST /admin/organizations/becomeOrg
  def becomeOrg
    id = params[:orgid].to_i
    if !Organization.find_by_id(id)
      flash[:error] = "Org not found."
      redirect_to admin_root_url
    else
      current_user.organization = Organization.find(id)
      if current_user.save
        flash[:notice] = "You have been switched to organization '#{current_user.organization.name}'."
        redirect_to admin_root_url
      else
        flash[:error] = "Error saving new organization id"
        redirect_to admin_root_url
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :email, :phone, :fname, :lname, :address1, :address2, :address3, :city, :province, :postalcode, :baddress1, :baddress2, :baddress3, :bcity, :bprovince, :bpostalcode)
    end
end
