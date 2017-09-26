class UsersController < ApplicationController
	include FlashMessages
	include AuthenticateUser
	include LogMessages

	before_action :logged_in_user
	before_action :orgadmin_user, except: [:show, :edit, :update]
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :correct_user, only: [:show, :edit, :update]

	def index
		@users = current_user.organization.users.paginate(page: params[:page])
	end

	def show
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.organization = current_user.organization
		if @user.save
			log("created new user #{@user.name}", @user)
			flash[:success] = "New user created!"
			redirect_to @user
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update_attributes(user_params)
			log("edited user #{@user.name}", @user)
			flash[:success] = "Profile updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		log("deleted user #{@user.name}", @user)
		flash[:success] = "User deleted"
		redirect_to users_url
	end

	private
		def user_params
			if current_user.orgadmin?
				params.require(:user).permit(:name, :email, :password, :password_confirmation, :default_slide_duration, :orgadmin)
			else
				params.require(:user).permit(:name, :email, :password, :password_confirmation, :default_slide_duration)
			end
		end

		# Get the user from the database
		def set_user
			@user = User.find(params[:id])
			redirect_to(users_path) unless current_user.organization == @user.organization
		end

		# Confirms the correct user.
		def correct_user
			if !current_user?(@user) && !current_user.orgadmin?
				redirect_to(users_path)
			end
		end
end
