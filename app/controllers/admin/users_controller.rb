class Admin::UsersController < ApplicationController
	include FlashMessages
	include AuthenticateUser

	before_action :logged_in_user
	before_action :soadmin_user
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def index
		@users = User.all.paginate(page: params[:page])
	end

	def new
		@user = User.new
		# New users created by SAdmin default to orgadmin
		@user.orgadmin = true
		@user.organization_id = params[:orgid]
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:success] = "New user created!"
			redirect_to [:admin, @user]
		else
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			flash[:success] = "Profile updated"
			redirect_to [:admin, @user]
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		flash[:success] = "User deleted"
		redirect_to admin_users_url
	end

	private
		# Get the user from the database
		def set_user
			@user = User.find(params[:id])
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :default_slide_duration, :organization_id, :orgadmin)
		end
end
