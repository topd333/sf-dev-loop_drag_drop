class Organization < ActiveRecord::Base
	has_many :users, inverse_of: :organization, dependent: :destroy
	has_many :players, inverse_of: :organization
	has_many :media_assets, inverse_of: :organization
	has_many :loop_assets, inverse_of: :organization
	has_many :slide_assets, inverse_of: :organization
	has_many :slide_templates, inverse_of: :organization
	has_many :slide_media_hooks, inverse_of: :organization
	has_many :campaigns, inverse_of: :organization
	has_many :user_logs, inverse_of: :organization
	
	validates :name, presence: true, length: { minimum: 3, maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
	validates :phone, length: { minimum: 10, maximum: 100 }
	validates :fname, presence: true, length: { maximum: 50 }
	validates :lname, presence: true, length: { maximum: 50 }
	validates :address1, presence: true, length: { maximum: 100 }
	validates :address2, length: { maximum: 100 }
	validates :address3, length: { maximum: 100 }
	validates :city, presence: true, length: { maximum: 255 }
	validates :province, presence: true, length: { maximum: 255 }
	validates :postalcode, presence: true, length: { maximum: 16 }
	validates :baddress1, presence: true, length: { maximum: 100 }
	validates :baddress2, length: { maximum: 100 }
	validates :baddress3, length: { maximum: 100 }
	validates :bcity, presence: true, length: { maximum: 255 }
	validates :bprovince, presence: true, length: { maximum: 255 }
	validates :bpostalcode, presence: true, length: { maximum: 16 }

end
