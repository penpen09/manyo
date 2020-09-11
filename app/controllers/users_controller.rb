class UsersController < ApplicationController
  before_action :current_user

  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @current_user.id != @user.id
      redirect_to tasks_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation,)
  end
end
