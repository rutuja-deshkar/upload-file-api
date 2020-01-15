class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist
  # before_save :ensure_authentication_token


  def after_database_authentication
    p "creating token"
    @token = Devise.friendly_token
    p "token #{@token}"
    current_user.authentication_token = @token
    # current_user.token_valid_time_in_minutes = 60
    # current_user.token_validity_end_by = Time.now + 60  * 60
    current_user.save
    p "current_user #{current_user}"
    format.json { render json: @token }
  end

  has_many_attached :files
  validates :email, :encrypted_password, presence: true


end
