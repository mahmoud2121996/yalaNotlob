class NotificationsController < ApplicationController
    before_action :authenticate_user!
    def index
        @notifications = Notification.where(to_id: current_user).limit(4).order('created_at DESC')
    end
    
    def showAllNotifications
        @notifications = Notification.where(to_id: current_user).order('created_at DESC')
    end
    

    def mark_as_read
        @notifications = Notification.where(to_id: current_user).unread
        @notifications.update_all(read: Time.now)
        render json: {success: true}
    end
    
    
end
