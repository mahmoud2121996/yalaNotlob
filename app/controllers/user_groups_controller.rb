class UserGroupsController < ApplicationController
  def index
  end

  def new
  end

  def show
  end

  def create
    @user = User.find_by(email: params[:email])
        if @user.nil?
            flash[:user_group_errors] = "No user exists with this email"
        elsif @user.id == current_user.id
            flash[:user_group_errors] = "You can't add yourself to this group"
        else
            @user_group = UserGroup.find_by(user_id: @user.id, group_id: params[:group_id])
            if @user_group.nil?
                @user_group = UserGroup.create(user_id: @user.id, group_id: params[:group_id])
                unless @user_group.persisted?
                    flash[:user_group_errors] = @user_groups.errors.full_messages
                end
            else
                flash[:user_group_errors] = "User Already Exist in this Group"
            end
        end
        redirect_to group_url(:id => params[:group_id])
  end

  def update
  end

  def edit
  end

  def destroy
    @users = UserGroup.where(group_id: params[:id], user_id: params[:user_id])
        @users.destroy_all
        redirect_to group_url(params[:id])
  end
end
