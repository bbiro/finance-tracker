class FriendshipsController < ApplicationController
  
  def create
    #byebug
    current_user.friendships.build(friend_id: params[:friend])

    if current_user.save
      flash.now[:notice] = "Friend added"
    else
      flash.now[:alert] = "There was something wrong with the friend request"
    end

    list_friends
  end

  def destroy

    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash.now[:notice] = "Friend was removed."
    list_friends
    
  end

  def list_friends
      @my_friends = current_user.friends

      respond_to do |format|
          format.js { render partial: 'users/friend_list'}
      end
  end
end
