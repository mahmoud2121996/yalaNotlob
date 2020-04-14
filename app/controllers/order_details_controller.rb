class OrderDetailsController < ApplicationController
  def index
    @user = current_user
    @details = OrderDetail.where(order_id: params[:order])
    @order = Order.find(params[:order])
    @newDetail = OrderDetail.new
    @users = OrderDetail.where(order_id: params[:order])
    @invited_users = InvitedUser.where(order_id: params[:order])
  end

  def create
  @detail = OrderDetail.new 
  @detail.user_id = current_user.id
  @detail.order_id = params[:order_id]
  @detail.item_name = params[:item]
  @detail.amount = params[:amount]
  @detail.price = params[:price]
  @detail.comment = params[:comment]
  @detail.save
  redirect_to :controller => 'order_details', :action => 'index' ,:order => params[:order_id]
  end

  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy
    @detail = OrderDetail.find(params[:id])
    id = @detail.order_id
    @detail.delete
    redirect_to :controller => 'order_details', :action => 'index' ,:order => id
  end
end
