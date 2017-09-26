class TemplateAddonsController < ApplicationController
	include AuthenticateUser

	before_action :logged_in_user
	before_action :soadmin_user
	before_action :set_template_addon, only: [:show, :edit, :update, :destroy]

	# GET /template_addon/new
	def new
		@template_addon = TemplateAddon.new
	end

	# GET /template_addon/1/edit
	def edit
	end

	# POST /template_addon
	def create
		@template_addon = TemplateAddon.new(template_addon_params)
		@template_addon.organization = current_user.organization

		if @template_addon.save
			redirect_to root_path, notice: 'Template addon was successfully created.'
		else
			render :new
		end
	end

	# PATCH/PUT /template_addon/1
	def update
		if @template_addon.update(template_addon_params)
			redirect_to root_path, notice: 'Template addon was successfully updated.'
		else
			render :edit
		end
	end

	private
		def set_template_addon
			@template_addon = TemplateAddon.find(params[:id])
			redirect_to(root_url) unless current_user.organization == @template_addon.organization
		end

		# Never trust parameters from the scary internet, only allow the whitelist through
		def template_addon_params
			params.require(:template_addon).permit(:file, :displayname)
		end

end

# TODO SECURE THIS!