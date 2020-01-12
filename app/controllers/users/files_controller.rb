class Users::FilesController < ApplicationController
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
      else
        render json: error_json, status: :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  # show all files for the user
  def index
    @user = User.find(params[:user_id])
    if @user.present?
      if @user.files.attached?
        render :index
      else
        render json: error_files(@user), status: :not_found
      end
    else
      head :not_found
    end
  end

  # download
  def download
    @user = User.find(params[:user_id])
    p "user: #{@user.inspect}"
    if @user.present?
      @user.files.each do |file|
        if file.blob_id == params[:id].to_i
          path = rails_blob_url(file)
          redirect_to path
          # send_file @path, :disposition => "attachment", x_sendfile: true
        end
      end
    end
  end

  # delete files
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

  def error_json(user)
    { errors: user.errors.full_messages }
  end


  def error_files(user)
    {
      user: {
        id: user.id,
        email: user.email,
        message: "No files found"
      }
    }
  end
end


