class Users::FilesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_user, only: [:create, :show, :destroy, :download]

  # attach files for the user
  def create
    @user = User.find(params[:user_id])
    if current_user?
      if @user.present?
        @user.update(user_params) ? render_create : render_error_json(@user)
      else
        head :not_found
      end
    else
      render_unauthorized_error
    end
  end

  # show all files for the user
  def index
    @user = User.find(params[:user_id])
    if current_user?
      if @user.present?
        @user.files.attached? ? render_index : render_error_files(@user)
      else
        head :not_found
      end
    else
      render_unauthorized_error
    end
  end

  # download files
  def download
    @user = User.find(params[:user_id])
    if @user.present?
      @user.files.each do |file|
        if file.blob_id == params[:id].to_i
          path = rails_blob_url(file)
          send_data path, disposition: "attachment", x_sendfile: true
        else
          head :not_found
        end
      end
    end
  end

  # delete files
  def destroy
    @user = User.find(params[:user_id])
    if current_user?
      if @user.present?
        if @user.files.any?
          @user.files.each do |file|
            find_and_delete_file(file, @user)
          end
        end
      else
        head :not_found
      end
    else
      render_unauthorized_error
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def user_params
    params.require(:user).permit(:email, :password, files: [])
  end

  def current_user?
    @user == current_user
  end

  def find_and_delete_file(file, user)
    if file.blob_id == params[:id].to_i
      if file.purge
        render_destroy_success(user)
      else
        render_error_json(user)
      end
    else
      head :not_found #  file id not found
    end
  end

  def render_error_json(user)
    render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
  end

  def render_index
    render :index, status: :ok
  end

  def render_create
    render :create, status: :created
  end

  def render_error_files(user)
    render json:
    {
      user: {
        id: user.id,
        email: user.email,
        message: "No files found"
      }
    }, status: :not_found
  end

  def render_unauthorized_error
    render json: { success: false }, status: 401
  end

  def render_destroy_success(user)
    render json: {
      user_id: user.id,
      file_id: params[:id],
      success: true,
      message: "Files deleted"
    }, status: :ok
  end
end
