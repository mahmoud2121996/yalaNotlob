class OrdersController < ApplicationController
  def index
    # @user_id = current_user.id
    @orders = current_user.orders
  end

  # def create
  #   @order= User.find(current_user.id).orders.create(order_params)
   
  #   # @post= Post.new 
  #   # @post.title=params[:title]
  #   # @post.content=params[:content]
  #   # @post.save
  #   if @order.id 
  #    redirect_to orders_path
  #   else 
  #     render :new
  #   end

  # end

  def new
    @order = Order.new;
  end

  def show
    redirect_to :controller => 'order_details', :action => 'index' ,:order => params[:id]
  end

  def create
    users = params['id'];
    groups = params['groups']
    @order = Order.new;
    @order.user_id = current_user.id;
    @order.order_for = params['order_for'];
    @order.restaurant = params['restaurant_name'];
    @order.status = 0;
    @order.image = params[order_params]
    

    if(@order.save())
      if(users != nil)
        users.each { |user| 
        @order.invited_users.create([{ user_id: user, order_id: @order.id, status: 1}]) 
        @order.update(invited: @order.invited+1)
        Notification.create(from_id: current_user.id, to_id: user,order_id: @order.id, notification_type: 2)
      }
      elsif(groups != nil)
        groups.each { |group|
          @group = Group.find(group)
          members = @group.group_members
          members.each { |member| 
          @order.invited_users.create([{ user_id: member.user_id, order_id: @order.id, status: 0}]) 
          Notification.create(from_id: current_user.id, to_id: member, order_id: @order.id, notification_type: 2)
        }
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
