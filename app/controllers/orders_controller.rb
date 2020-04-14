class OrdersController < ApplicationController

  def new
    @order = Order.new;
  end


  def create
    # users = params['id'];
    # groups = params['groups']
    puts params
    @order = Order.new;
    @order.user_id = current_user.id;
    @order.order_for = params['order_for'];
    @order.restaurant = params['restaurant_name'];
    @order.status = 1;
    @order.image = params[order_params]
    

    if(@order.save())
      if(users != nil)
        users.each { |user| @order.invited_users.create([{ user_id: user }]) }
      elsif(groups != nil)
        groups.each { |group|
          @group = Group.find(group)
          members = @group.group_members
          members.each { |member| @order.invited_users.create([{ user_id: member.user_id }]) }
        }
      end
    end
    
    message = "Order submitted successfully"
    redirect_to "/orders/new", :flash => { :error => message }
  end

  def order_params
    params.require(:order).permit(:image)
  end
end
