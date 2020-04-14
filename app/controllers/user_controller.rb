class UserController < ApplicationController
  def index
    @user_orders = Order.where(user_id: current_user.id).reverse_order
    @friends_orders = Order.where(user_id: [current_user.friends.pluck("friend_id")]).reverse_order
  end
end
