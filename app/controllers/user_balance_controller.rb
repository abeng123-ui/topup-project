class UserBalanceController < ApplicationController
  before_action :set_user_balance, only: [:show, :update, :destroy]

  def index
    @data = UserBalance.all
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def create
    @data = UserBalance.create!(user_balance_params)
    msg = { :status => 200, :message => "Success create data!", :data => @data }
    render :json => msg
  end

  def show
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def update
    @data.update(user_balance_params)

    msg = { :status => 200, :message => "Successfully updated!", :data => @data }
    render :json => msg
  end

  def destroy
    @data.destroy

    msg = { :status => 200, :message => "Successfully delete!" }
    render :json => msg
  end

  private

  def user_balance_params
    params.permit(:user_id, :balance, :balance_achieve)
  end

  def set_user_balance
    @data = UserBalance.find(params[:id])
  end
end

