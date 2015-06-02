class UsersController < ApplicationController
  before_action :require_login, :only => [:show, :edit, :update]
  before_action :require_logout, :except => [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new signup_params
    if @user.save
      flash[:notice] = 'User created successfully.'
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.uses_oauth?
      flash[:alert] = 'User data not locally managed.'
      redirect_to user_path
      return
    end
    if @user.update(user_params)
      flash[:notice] = 'User was successfully updated.'
    end
    render :edit
  end

  def forgot
    email = forgot_params[:email]
    @user = User.local_auth.with_email(email).first
    if @user
      UserMailer.forgot_password(@user).deliver
      flash[:notice] = 'Password recovery email sent.'
      redirect_to root_path
    else
      flash[:alert] = 'No user with this email exists.'
      redirect_to login_path
    end
  end

  def recover
    @token = params[:token]
    @user = User.local_auth.find_using_perishable_token @token
    if @user
      flash[:notice] = 'You have authenticated via the link in your email. ' +
        'Change your password immediately for continued access to your account.'
    else
      flash[:alert] = 'Invalid token.'  
      redirect_to root_path
    end
  end

  def reset
    @token = params[:token]
    @user = User.local_auth.find_using_perishable_token @token
    if !@user
      flash[:alert] = 'Invalid token.'  
      redirect_to root_path
    elsif !@user.update(reset_params)
      render :recover
    else
      flash[:notice] = 'Password reset successfully.'
      redirect_to root_path
    end
  end

private

  def signup_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :password_confirmation)
  end

  def reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def forgot_params
    params.require(:user).permit(:email)
  end

end
