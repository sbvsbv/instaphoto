class ProfilesController < ApplicationController
	before_action :set_user, except: [:my_photos, :subscribes_list, :friends_photos]
  
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

  def my_photos
  	@photos = current_user.photos.order('created_at DESC')
  end

  def subscribes_list
  	@friends = User.where(id: current_user.subscriptions.pluck(:frend_id))
  end

  def friends_photos
  	@photos = Photo.where(user_id: current_user.subscriptions.pluck(:frend_id)).order('created_at DESC')
  end

  private

  def set_user
      @user = User.find(params[:id])
  end
end
