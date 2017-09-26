class Admin::PayProgram < ActiveRecord::Base
	has_many :players, inverse_of: :admin_pay_program

	validates :name, presence: true, length: { minimum: 2, maximum: 50 }
	validates :description, length: { maximum: 500 }
	validates :price, numericality: { greater_than_or_equal_to: 0 }
	validates :period, inclusion: { in: %w(monthly yearly), message: "'%{value}' is not a valid pay period." }
end
