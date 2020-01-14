class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist


  # def after_database_authentication
  #   @token = Devise.friendly_token
  #   current_user.user_token = @token
  #   current_user.token_valid_time_in_minutes = 60
  #   current_user.token_validity_end_by = Time.now + 60  * 60
  #   current_user.save
  #   format.json { render json: @token }
  # end

  has_many_attached :files
  validates :email, :encrypted_password, presence: true
end
