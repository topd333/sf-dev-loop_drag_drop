class Admin::PayProgramsController < ApplicationController
  include AuthenticateUser
  
  before_action :logged_in_user
  before_action :soadmin_user
  before_action :set_admin_pay_program, only: [:show, :edit, :update, :destroy]

  # GET /admin/pay_programs
  # GET /admin/pay_programs.json
  def index
    @admin_pay_programs = Admin::PayProgram.all
  end

  # GET /admin/pay_programs/1
  # GET /admin/pay_programs/1.json
  def show
  end

  # GET /admin/pay_programs/new
  def new
    @admin_pay_program = Admin::PayProgram.new
  end

  # GET /admin/pay_programs/1/edit
  def edit
  end

  # POST /admin/pay_programs
  # POST /admin/pay_programs.json
  def create
    @admin_pay_program = Admin::PayProgram.new(admin_pay_program_params)

    respond_to do |format|
      if @admin_pay_program.save
        format.html { redirect_to @admin_pay_program, notice: 'Pay program was successfully created.' }
        format.json { render :show, status: :created, location: @admin_pay_program }
      else
        format.html { render :new }
        format.json { render json: @admin_pay_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pay_programs/1
  # PATCH/PUT /admin/pay_programs/1.json
  def update
    respond_to do |format|
      if @admin_pay_program.update(admin_pay_program_params)
        format.html { redirect_to @admin_pay_program, notice: 'Pay program was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_pay_program }
      else
        format.html { render :edit }
        format.json { render json: @admin_pay_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pay_programs/1
  # DELETE /admin/pay_programs/1.json
  def destroy
    @admin_pay_program.destroy
    respond_to do |format|
      format.html { redirect_to admin_pay_programs_url, notice: 'Pay program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_pay_program
      @admin_pay_program = Admin::PayProgram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_pay_program_params
      params.require(:admin_pay_program).permit(:name, :description, :price, :available, :period)
    end
end
