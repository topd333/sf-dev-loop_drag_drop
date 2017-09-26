module LogMessages
	extend ActiveSupport::Concern

	def log(action, loggable)
		UserLog.create(organization: current_user.organization, user: current_user, loggable: loggable, action: action)
	end
end