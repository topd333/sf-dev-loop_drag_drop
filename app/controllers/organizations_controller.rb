class OrganizationsController < ApplicationController
  include FlashMessages
  include AuthenticateUser

  before_action :logged_in_user
  before_action :orgadmin_user, only: [:edit, :update]
  before_action :set_organization, only: [:show, :edit, :update]

  # GET /organizations/1
  def show
  end

  # GET /organizations/1/edit
  def edit
  end

  # PATCH/PUT /organizations/1
  def update
    if @organization.update(organization_params)
      redirect_to @organization, notice: 'Organization was successfully updated.'
    else
      render :edit
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
      if !current_user.soadmin && current_user.organization != @organization
        redirect_to current_user.organization
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params.require(:organization).permit(:name, :email, :phone, :fname, :lname, :address1, :address2, :address3, :city, :province, :postalcode, :baddress1, :baddress2, :baddress3, :bcity, :bprovince, :bpostalcode)
    end
end
