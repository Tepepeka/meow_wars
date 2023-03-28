class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :is_admin?

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(post_params)
    redirect_to admin_users_path, notice: "User was successfully updated."
    else
      render :new, notice: "User was not updated!"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User was successfully destroyed."
  end

  #######
  private
  #######

  def set_user
      @user=User.find(params[:id])
  end

  def post_params
    params.require(:user).permit(:name, :admin)
  end

  def is_admin?
      if current_user.admin? != true
        redirect_to root_path, notice: "Must be Admin."
      end
  end

end