class Admin::HardwareType < ActiveRecord::Base
	has_many :players, inverse_of: :admi_hardware_type
end
