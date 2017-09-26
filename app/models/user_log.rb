class UserLog < ActiveRecord::Base
  belongs_to :organization
  belongs_to :user
  belongs_to :loggable, polymorphic: true
end
