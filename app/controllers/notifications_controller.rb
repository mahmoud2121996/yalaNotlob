class NotificationsController < ApplicationController
    before_action :authenticate_user!
    def index
        @notifications = Notification.where(to_id: current_user).unread
    end

    def mark_as_read
        @notifications = Notification.where(to_id: current_user).unread
        @notifications.update_all(read: true)
        render json: {success: true}
    end
    
    
end
