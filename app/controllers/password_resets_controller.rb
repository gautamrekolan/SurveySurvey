class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    flash[:success] = "Email Sent with Password Reset Instructions"
    redirect_to root_url
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired"
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password Has Been Reset"
    else
      render :edit
    end
  end

end
