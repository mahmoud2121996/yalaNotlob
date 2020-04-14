class FriendController < ApplicationController

  def friends_index
    @friends = User.joins("INNER JOIN friends ON users.id = friends.friend_id")
                      .where("friends.user_id"=> current_user.id);
    
    @friends
  end

  def add_friend
    @user = User.find_by(email: params[:email][:email])
    @friend = Friend.new(user_id: current_user.id, friend_id: @user.id )
    if( @friend.user_id == @friend.friend_id)
      redirect_to friends_path, notice: "You can't add yourself"  
    elsif @friend.save
      Notification.create(from_id: current_user.id, to_id: @friend.friend_id, notification_type: 1)
      redirect_to friends_path, notice: "Added successfully."
    elsif @friend.errors.details[:friend_id][0][:error] == :taken 
      redirect_to friends_path, notice: "Already your friend."
    end
  end

  def remove_friend
    friend = Friend.find_by(friend_id: params[:format])
    if friend.destroy
      redirect_to friends_path, notice: "Removed successfully."
    else 
      redirect_to friends_path, notice: "Something went wrong, plese try again."
    end
  end

end
  