class Admin::HardwareTypesController < ApplicationController
  include AuthenticateUser
  
  before_action :logged_in_user
  before_action :soadmin_user
  before_action :set_admin_hardware_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/hardware_types
  # GET /admin/hardware_types.json
  def index
    @admin_hardware_types = Admin::HardwareType.all
  end

  # GET /admin/hardware_types/1
  # GET /admin/hardware_types/1.json
  def show
  end

  # GET /admin/hardware_types/new
  def new
    @admin_hardware_type = Admin::HardwareType.new
  end

  # GET /admin/hardware_types/1/edit
  def edit
  end

  # POST /admin/hardware_types
  # POST /admin/hardware_types.json
  def create
    @admin_hardware_type = Admin::HardwareType.new(admin_hardware_type_params)

    respond_to do |format|
      if @admin_hardware_type.save
        format.html { redirect_to @admin_hardware_type, notice: 'Hardware type was successfully created.' }
        format.json { render :show, status: :created, location: @admin_hardware_type }
      else
        format.html { render :new }
        format.json { render json: @admin_hardware_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/hardware_types/1
  # PATCH/PUT /admin/hardware_types/1.json
  def update
    respond_to do |format|
      if @admin_hardware_type.update(admin_hardware_type_params)
        format.html { redirect_to @admin_hardware_type, notice: 'Hardware type was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_hardware_type }
      else
        format.html { render :edit }
        format.json { render json: @admin_hardware_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/hardware_types/1
  # DELETE /admin/hardware_types/1.json
  def destroy
    @admin_hardware_type.destroy
    respond_to do |format|
      format.html { redirect_to admin_hardware_types_url, notice: 'Hardware type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_hardware_type
      @admin_hardware_type = Admin::HardwareType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_hardware_type_params
      params.require(:admin_hardware_type).permit(:model_number, :description)
    end
end
