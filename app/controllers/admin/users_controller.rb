class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update,:destroy]
  before_action :current_user_admin

  def index
    @users = User.select(:id, :name, :email,:admin).includes(:tasks).page(params[:page]).per(10)
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_pash(@user.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if params[:back]
      render :edit
    else
      if @user.update(user_params)
        redirect_to admin_user_path, notice: '編集しました'
      else
        render :edit
      end
    end
  end

  def show
    @tasks = @user.tasks.page(params[:page]).per(10)
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_pash, notice: '削除しました'
    else
      redirect_to admin_users_path
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
  def current_user_admin
    unless current_user.admin
      redirect_to tasks_path
    end
  end
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation,)
  end
end
