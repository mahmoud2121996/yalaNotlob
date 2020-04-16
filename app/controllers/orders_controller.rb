class OrdersController < ApplicationController
  def index
    # @user_id = current_user.id
    @orders = current_user.orders
    @orders = InvitedUser.where(user_id: current_user.id)
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
    puts params
    users = params['id'];
    groups = params['groups']
    @order = Order.new(order_params)
    @order.user_id = current_user.id;
    @order.order_for = params['order_for'];
    @order.restaurant = params['restaurant_name'];
    @order.status = 0;
    
    
    

    if(@order.save())
      if(users != nil)
        users.each { |user| 
        @order.invited_users.create([{ user_id: user, order_id: @order.id, status: 0}]) 
        @order.invited_users.create([{ user_id: current_user.id, order_id: @order.id, status: 1}])
        @order.update(invited: @order.invited+1)
        Notification.create(from_id: current_user.id, to_id: user,order_id: @order.id, notification_type: 2)
      }
      elsif(groups != nil)
        groups.each { |group|
          @group = Group.find(group)
          members = @group.user_groups
          members.each { |member| 
          @order.invited_users.create([{ user_id: member.user_id, order_id: @order.id, status: 0}]) 
          @order.invited_users.create([{ user_id: current_user.id, order_id: @order.id, status: 1}])
          @order.update(invited: @order.invited+1)
          Notification.create(from_id: current_user.id, to_id: member, order_id: @order.id, notification_type: 2)
        }
        }
      end
    end
    
    message = "Order submitted successfully"
    redirect_to "/orders/new", :flash => { :error => message }
  end

  def update
    @order = Order.find(params[:id])
    @order.status = 1
    @order.save
    redirect_to :orders
  end

  def destroy
    @order = Order.find(params[:id])
    @order.delete
    redirect_to :orders
  end
  
  private
  def order_params
    params.require(:order).permit(:image)
  end
end
