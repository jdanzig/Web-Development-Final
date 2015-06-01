# Adapted from: https://github.com/binarylogic/authlogic_example/blob/master/app/controllers/user_sessions_controller.rb

class UserSessionsController < ApplicationController

  before_action :require_logout, :only => [:new, :create]
  before_action :require_login, :only => [:destroy]
  
  def new
    @user = User.new
    @user_session = UserSession.new
  end
  
  def create
    @user = User.new
    @user_session = UserSession.new(login_params)
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_to root_path
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_path
  end

private

  def login_params
    params.require(:user_session).permit(:email,:password)
  end

end