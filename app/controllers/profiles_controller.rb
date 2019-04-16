class ProfilesController < ApplicationController
	before_action :set_user
  
  def show
  end

  def subscribe
  	if current_user.id == @user.id 
  		  		redirect_to profile_path(@user), notice: "You cannot subscribe to yourself."
		else
	  	if current_user.subscriptions.exists?(frend_id: @user.id)
	  		redirect_to profile_path(@user), notice: "You are already subscribed to this user."
	  	else
		  	@subscription = current_user.subscriptions.build
		  	@subscription.frend_id = @user.id
		  	@subscription.save
		  	if @subscription.save
		  		redirect_to profile_path(@user), notice: "You are subscrube to current user"
		  	end
		  end
		end
  end

  def unsubscribe
  	if current_user.id == @user.id 
  		redirect_to profile_path(@user), notice: "You cannot unsubscribe to yourself."
		else
	  	if current_user.subscriptions.exists?(frend_id: @user.id)
		  	@subscription = current_user.subscriptions.find_by_frend_id(@user.id)
		  	@subscription.destroy
		 		redirect_to profile_path(@user), notice: "You are not subscrube to current user"
		 	else
		 		redirect_to profile_path(@user), notice: "You were not subscribed to this user"
		 	end
		end 	
  end

  private

  def set_user
      @user = User.find(params[:id])
    end
end
