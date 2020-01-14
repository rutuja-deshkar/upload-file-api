class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # GET /resource/sign_up
  def new
    # super
    render(status: :bad_request) && return if User.exists?(email: sign_up_params['email', 'password'])
    build_resource(sign_up_params)
    resource.save
    render_resource(resource)
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    render_resource(resource)
  end

  # original methods all 4
  # def new
  #   @user = User.new
  # end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     render json: @user, status: :created, location: @user
  #   else
  #     render_error
  #   end
  # end

  # def show
  #   @user = User.find(params[:id])
  #   if @user.present?
  #     render json: @user, status: :ok
  #   else
  #     head :not_found
  #   end
  # end

  # def destroy
  #   p "params #{params[:id]}"
  #   @user = User.find(params[:id])
  #   if @user.present?
  #     p "present"
  #     if @user.destroy
  #       render json: {
  #         success: true
  #       }, status: :ok
  #       p "in user delete"
  #     else
  #       render_error
  #     end
  #   end
  # end
   # this is from stackoverflow
  # def destroy
  #   resource.destroy
  #   Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
  #   set_flash_message :notice, :destroyed if is_flashing_format?
  #   yield resource if block_given?
  #   respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  # end

  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, files: [])
  end

  def render_error
    render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
  end
end
