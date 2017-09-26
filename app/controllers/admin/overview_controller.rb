class Admin::OverviewController < ApplicationController
  include FlashMessages
  include AuthenticateUser

  before_action :logged_in_user
  before_action :soadmin_user

  def index
  end

  private
    
end
