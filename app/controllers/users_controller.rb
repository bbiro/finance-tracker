class UsersController < ApplicationController
  
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @my_friends = current_user.friends
    flash.now[:alert] = "You don't have any friends, yet." if @my_friends.empty?
  end

  def search
    byebug
    if params[:email].present?
        email = params[:email].strip!
        @user = User.find_by(email: email)
        if @user
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

end
