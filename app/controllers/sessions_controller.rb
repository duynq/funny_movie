class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if login || create_user_for_first_time?
      flash[:success] = 'Login successfully'
    elsif @user&.errors&.messages.present?
      flash[:danger] = "Email #{@user.errors.messages[:email].first}"
    end
    redirect_to :root
  end

  def destroy
    warden.logout
    flash[:success] = 'Logout successfully'
    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:email, :password_digest)
  end

  def login
    User.exists?(email: user_params[:email]) && authenticate!
  end

  def create_user_for_first_time?
    return if User.exists?(email: user_params[:email])

    @user = User.new(user_params)
    @user.password = user_params[:password_digest] if user_params[:password_digest].present?
    warden.set_user(@user) if @user.save
  end
end
