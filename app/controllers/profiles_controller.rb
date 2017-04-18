class ProfilesController < ApplicationController
  
  #Devise authenticate_user! function to make sure users are logged in before allowing them to perform these functions
  before_action :authenticate_user!
  
  #user can only edit their own info
  before_action :only_current_user
  
  # GET to /users/:user_id/profile/new
  def new
    # Render blank profile details form
    @profile = Profile.new
  end
  
  # POST to /users/:user_id/profile
  def create
    # Ensure that we have the user who is filling out form
    @user = User.find( params[:user_id] )
    # Create profile linked to this specific user
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :new
    end
  end
  
 #get request to /users/:user_id/profile/edit 
def edit 
  @user = User.find( params[:user_id])
  @profile = @user.profile
end

#PUT (PATCH) to /users/:user_id/profile
def update
  #retrieve user from database
  @user = User.find( params[:user_id])
  #retrieve their profile
  @profile = @user.profile
  #mass assign edited profile attributes and save
  if @profile.update_attributes(profile_params)
    flash[:success] = "Profile updated"
    #redirect user to their profile page
    redirect_to user_path(id:params[:user_id])
  else
    render action: edit
  end
end
  
  
  private
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      #current user is a Devise function
      redirect_to(root_url) unless @user == current_user
    end
    
  
end