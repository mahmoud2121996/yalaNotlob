class FriendController < ApplicationController

    def friends_index
      @friends = User.joins("INNER JOIN friends ON users.id = friends.friend_id")
                        .where("friends.user_id"=> current_user.id);
      
      @friends
    end
  
    def add_friend
      @user = User.find_by(email: params[:email][:email])
      @friend = Friend.new
      @friend.user_id = current_user.id
      @friend.friend_id = @user.id
      @friend.save
      redirect_to friends_path
    end
  
    def remove_friend
      @friend = Friend.find_by(friend_id: params[:format])
      @friend.destroy
      redirect_to friends_path
    end
  
  end
  