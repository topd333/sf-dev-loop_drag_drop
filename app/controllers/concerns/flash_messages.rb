module FlashMessages
	extend ActiveSupport::Concern

	def flash_page_not_available
		flash[:error] = "The page you requested is not available"
	end

	def flash_please_log_in
		flash[:alert] = "Please log in."
	end

	def flash_org_admin_rights
		flash[:error] = "This page requires admin rights"
	end

	def flash_so_admin_rights
		flash[:error] = "The page you requested is not available"
	end
end