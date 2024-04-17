# class AdminController < ApplicationController
#   before_action :authenticate_user!, :authorize_admin!

#   def index
#     @unapproved_users = User.where(approved: false).where.not(user_type: "Admin")
#   end

#   def approve_user
#     @user = User.find(params[:id])
#     @user.update(approved: true)
#     flash[:notice] = "User approved successfully"
#     redirect_to root_path
#   end

#   def reject_user
#     @user = User.find(params[:id])
#     @user.destroy
#     flash[:notice] = "User rejected successfully"
#     redirect_to root_path
#   end

#   private

#   def authorize_admin!
#     redirect_to root_path unless current_user.admin?
#   end

#   def active_for_authentication?
#     super && approved?
#   end
# end
