class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    # form submits here
    # User.create user_params
    # redirect_to users_path

    user = User.new(user_params)

    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])

      user.image = req["public_id"]

    end
      user.save
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
