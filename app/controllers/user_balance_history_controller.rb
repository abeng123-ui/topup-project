class UserBalanceHistoryController < ApplicationController
  before_action do
    authenticate_request!
    check_is_admin
  end

  def index
    @data = UserBalanceHistory.all
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def create
    @data = UserBalanceHistory.create!(set_params)
    msg = { :status => 200, :message => "Success create data!", :data => @data }
    render :json => msg
  end

  def show
    @data = UserBalanceHistory.find(params[:id])
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def update
    @data = UserBalanceHistory.find(params[:id])
    @data.update(set_params)

    msg = { :status => 200, :message => "Successfully updated!", :data => @data }
    render :json => msg
  end

  def destroy
    @data = UserBalanceHistory.find(params[:id])
    @data.destroy

    msg = { :status => 200, :message => "Successfully delete!" }
    render :json => msg
  end

  private

  def set_params
    params.permit(:user_balance_id, :balance_before, :balance_after, :activity, :type, :ip, :location, :user_agent, :author)
  end

end

