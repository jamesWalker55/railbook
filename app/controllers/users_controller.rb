class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # send mail after user creation
  after_create :send_welcome_mail
  def send_welcome_mail
    UserMailer.with(user: self).welcome_email.deliver_later
  end

  # GET /users or /users.json
  def index
    @users = User.all.order(:name)
  end

  # GET /users/1 or /users/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.fetch(:user, {})
    end
end
