class UsersController < ApplicationController
  
  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user 
  end

  def my_friends
    @my_friends = current_user.friends
    flash.now[:alert] = "You don't have any friends, yet." if @my_friends.empty?
  end

  def search
    if params[:search].present?
        @users = User.search(params[:search])
        @users = current_user.except_current_user(@users)
        if !@users.blank?
            respond_to do |format|
                format.js { render partial: 'users/friend_result'}
            end
        else
            respond_to do |format|
                flash.now[:alert] = "User was not found in the system."   
                format.js { render partial: 'users/friend_result'}
            end
        end
    else 
        respond_to do |format|
            flash.now[:alert] = "Please enter an email to search"   
            format.js { render partial: 'users/friend_result'}
        end
    end
  end

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

end