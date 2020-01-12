class Users::RegistrationsController < Devise::RegistrationsController
  # skip_before_action :authenticate_user!, only: [:new, :create, :show, :cancel]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created, location: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
  end

  def show
    @user = User.find(params[:id])
    if @user.present?
      render json: @user, status: :ok
    else
      head :not_found
    end
  end

  def destroy
    p "params #{params[:id]}"
    user = User.find(params[:id])
    if user.present?
      p "present"
      if user.destroy
        render json: {
          message: "user deleted"
        }, status: :ok
        p "in user delete"
      else
        render json: user.errors, status: :unprocessable_entity
      end
    end
  end

  # def create_avatar
  #   # check if user is signed_in?   --- before action authenticate user only create, delete, update
  #   # if yes, find user
  #   user = User.find(params[:id])
  #   p "in create avatar"
  #   p "user #{user.email}"
  #   p "current_user #{current_user.email}"
  #   if user.present? && user == current_user
  #     user = User.update(user_params)
  #   else
  #     head :not_found
  #   end
  #   # attach files to the user
  #   # return success or error message
  # end


  private
  def user_params
    params.require(:user).permit(:email, :password, files: [] )
  end

end
