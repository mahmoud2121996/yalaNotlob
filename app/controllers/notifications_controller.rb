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
        @notifications.update_all(read_at: Time.now)
        render json: {success: true}
    end
    
    def join
        @invited_user = InvitedUser.where(user_id: current_user.id, order_id: params['order_id'])
        @invited_user.update(status: 1)
        @order = Order.find(params['order_id'])
        @order.update(joined: @order.joined+1)
        @notifications = Notification.where(to_id: current_user, order_id: params['order_id'])
        @notifications.update(reacted: true)
        Notification.create(from_id: current_user.id, to_id: @order.user_id,notification_type: 3)
        redirect_to order_path(@order)
    end

    def cancel
        @invited_user = InvitedUser.where(user_id: current_user.id, order_id: params['order_id'])
        @invited_user.update(status: 2)
        @notifications = Notification.where(to_id: current_user, order_id: params['order_id'])
        @notifications.update(reacted: true)
        redirect_to root_path
    end
end
