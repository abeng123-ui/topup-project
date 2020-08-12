class UserController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    msg = { :status => 200, :message => "Success!", :data => @users }
    render :json => msg
  end

  def create
    @user = User.create!(user_params)
    msg = { :status => 200, :message => "Success create data!", :data => @user }
    render :json => msg
  end

  def show
    msg = { :status => 200, :message => "Success!", :data => @user }
    render :json => msg
  end

  def update
    @user.update(user_params)

    msg = { :status => 200, :message => "Successfully updated!", :data => @user }
    render :json => msg
  end

  def destroy
    @user.destroy

    msg = { :status => 200, :message => "Successfully delete!" }
    render :json => msg
  end

  private

  def user_params
    params.require(:username, :email, :password, :role).permit(:username, :email, :password, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
