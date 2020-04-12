class OrdersController < ApplicationController
  def index
    @orders = Order.all()
  end

  def create
    @order= User.find(current_user.id).orders.create(order_params)
   
    # @post= Post.new 
    # @post.title=params[:title]
    # @post.content=params[:content]
    # @post.save
    if @order.id 
     redirect_to orders_path
    else 
      render :new
    end
  end

  def new
    @order=Order.new
  end

  def edit
  end

  def show
  end

  def update
    @order = Order.find(params[:id])
    @order.status = 2
    @order.save
    redirect_to :orders
  end

  def destroy
  end
  private 
  def order_params
    params.require(:order).permit(:order_for, :restaurant ,:invited,:menu_pic)
  end  
end
