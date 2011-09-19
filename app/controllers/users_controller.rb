class UsersController < ApplicationController
  before_filter :authenticate, :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  before_filter :existing_user, :only => [:new, :create]
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
    @surveys = @user.surveys
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
      UserMailer.registration_confirmation(@user).deliver
    else
      @title = "Sign up"
      @user.password = nil
      @user.password_confirmation = nil
      render 'new'
    end
   end
   
   def edit
     @title = "Edit user"
   end
   
   def update
     @user = User.find(params[:id])
     if @user.update_attributes(params[:user])
       flash[:success] = "Your information was successfully updated"
       redirect_to @user
     else
       @title = "Edit user"
       render 'edit'
     end
   end
   
   def delete
     @user = User.find(params[:id])
   end   
   
   def destroy
     @user = User.find(params[:id])
     if current_user?(@user)
       flash[:info] = "You cannot delete yourself"
       redirect_to users_path
     else
       @user.destroy
       flash[:success] = "User was successfully deleted"
       redirect_to users_path
     end
   end
   
   def admin_create_user
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "User Successfully Added"
      redirect_to '/create-user'
     # UserMailer.registration_confirmation(@user).deliver
    else
      flash[:notice] = "User NOT Saved"
      @title = "Add New User"
      @user.password = nil
      @user.password_confirmation = nil
      render 'create-user'
    end
   end
end
