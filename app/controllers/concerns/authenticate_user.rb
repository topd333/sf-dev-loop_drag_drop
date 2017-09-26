module AuthenticateUser
  extend ActiveSupport::Concern
  include FlashMessages

  private
    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash_please_log_in
        redirect_to login_url
      end
    end

     # Checks the players access code
    def allowed_player
      player = Player.where(id: params[:player_id], access_code: params[:access_code]).take
      if player == nil
        render nothing: true, status: :unauthorized
        return
      end
      
      # If player doesn't have player identifier set yet, set it
      if player.uniqkey == nil
        player.uniqkey = params[:uniqkey]
        player.save
      else
        if player.uniqkey != params[:uniqkey]
          render nothing: true, status: :unauthorized
          return
        end
      end
    end

    # Confirms an soadmin user.
    def soadmin_user
      unless current_user.soadmin?
        flash_so_admin_rights
        redirect_to(root_path)
      end 
    end

    # Confirms an orgadmin user.
    def orgadmin_user
      unless current_user.orgadmin?
        flash_org_admin_rights
        redirect_to(root_path)
      end
    end
end