# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  respond_to :json
  # original method
  # def create
  #   user = User.find_by_email(sign_in_params[:email])

  #   if user && user.valid_password?(sign_in_params[:password])
  #     @current_user = user
  #     render json: { id: user.id, email: user.email, message: "You have logged in successfully" }, status: :ok
  #   else
  #     render json: { id: user.id, email: user.email, errors: { 'email or password' => ['is invalid'] } }, status: :unauthorized
  #   end
  # end

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end
end
