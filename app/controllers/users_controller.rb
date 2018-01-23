class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])

      user.image = req["public_id"]

    end
      user.save

      # The below will work with Luke's code in tunr. I've included it in here for your reference, but commented out as I do not have a sessions controller. The live `create method` here (ie the create method excluding the code commented out below) will work in a create method for other controllers e.g for uploading an image to notesController)


    # if user.persisted?
    #   # user successfully created, redirect to profile page for this user
    #   session[:user_id] = user.id
    #   redirect_to user
    # else
    #   # error creating user (probably a validation error)
    #   flash[:errors] = user.errors.full_messages
    #   redirect_to new_user_path
    # end

      # Delete the below redirect if you're using the user.persisted? if/else statements above, as the if/else deals with redirects
      redirect_to user_path(user)
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find params[:id]

    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])

      if req.has_key? 'public_id'
        user.image = req["public_id"]
      end
    end
    # update_attributes returns the updated objects, or nil if unsuccessful
    if user.update_attributes(user_params)
      redirect_to user
    else
      flash[:errors] = user.errors.full_messages
      redirect_to edit_user_path
    end


  end

  private

    # "strong params" for the artist form submit - only let through the fields
    # which we expect (i.e. the table fields the user is allowed to edit)
    def user_params
    params.require(:user).permit(:name, :email, :password)
    end
end
