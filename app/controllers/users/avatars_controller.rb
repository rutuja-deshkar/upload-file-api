class Users::AvatarsController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_user, only: [:create, :show, :destroy, :download]

  # attach files for the user
  def create
    # check if user is signed_in?   --- before action authenticate user only create, delete, update, not working
    # if yes, find user
    @user = User.find(params[:user_id])
    if @user.present? #&& user == current_user
      if @user.update(user_params)
        render :create, status: :created
        # render json: success_json(user), status: :created
      else
        render json: error_json, status: :unprocessable_entity
      end
    else
      head :not_found
    end
    # attach files to the user
    # return success or error message
  end

  # show all files for the user
  def show
    @user = User.find(params[:user_id])
    if @user.present?
      if @user.files.attached?
        render :show
      else
        render json: error_avatar(@user), status: :not_found
      end
    else
      head :not_found
    end
  end

  # download
  def download
  end

  def destroy
    @user = User.find(params[:user_id])
    if @user.present?
      if @user.files.any?
        @user.files.each do |file|
          if file.blob_id == params[:id].to_i
            if file.destroy
              render json: {
                user_id: @user.id,
                file_id: params[:id],
                success: true,
                message: "Files deleted"
              }, status: :ok
            else
              render json: error_json(user), status: :unprocessable_entity
            end
          end
        end
      end
    else
      head :not_found
    end
  end

  private

  def set_user
    user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:email, :password, files: [])
  end

  def success_json(user)
    {
      user: {
        id: user.id,
        email: user.email,
        message: "Files attached successfully",
        avatar: user.files
      }
    }
  end

  def error_json(user)
    { errors: user.errors.full_messages }
  end


  def error_avatar(user)
    {
      user: {
        id: user.id,
        email: user.email,
        avatar: "Avatar not attached"
      }
    }
  end
end


