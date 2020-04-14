class UserGroupsController < ApplicationController
    def index
        render "groups/index"
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
                    @friend = Friend.find_by(user_id: current_user.id, friend_id: @user.id)
                    unless @friend.nil?
                         @user_group = UserGroup.create(user_id: @user.id, group_id: params[:group_id])
                unless @user_group.persisted?
                        flash[:user_group_errors] = @user_groups.errors.full_messages
                    end
                else
                    flash[:user_group_errors] = ["User isn't a friend"]
                end 

                else
                    flash[:user_group_errors] = "User Already Exist in this Group"
                end
            end
            redirect_to group_url(:id => params[:group_id])
    end
    
    def destroy
        @group = Group.find_by(id: params[:id], user_id: current_user.id)
        unless @group.nil?
            @members = UserGroup.where(group_id: params[:id], user_id: params[:user_id])
            @members.destroy_all
            redirect_to group_url(params[:id])
        else
            flash[:group_error] = "You can't delete this group"
            redirect_to :groups
        end    
    end
end
