module UsersHelper
   
   def correct_user
     @user = User.find(params[:id])
     redirect_to root_path unless current_user?(@user)
   end
   
   def admin_user
     redirect_to root_path  unless current_user.admin?
   end
   
   def existing_user
     flash[:notice] = "You already have an account"
     redirect_to users_path if signed_in?
   end

end