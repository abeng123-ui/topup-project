class BalanceBankHistoryController < ApplicationController
  before_action :set_id, only: [:show, :update, :destroy]

  def index
    @data = BalanceBankHistory.all
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def create
    @data = BalanceBankHistory.create!(set_params)
    msg = { :status => 200, :message => "Success create data!", :data => @data }
    render :json => msg
  end

  def show
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def update
    @data.update(set_params)

    msg = { :status => 200, :message => "Successfully updated!", :data => @data }
    render :json => msg
  end

  def destroy
    @data.destroy

    msg = { :status => 200, :message => "Successfully delete!" }
    render :json => msg
  end

  private

  def set_params
    params.permit(:balance_bank_id, :balance_before, :balance_after, :activity, :type, :ip, :location, :user_agent, :author)
  end

  def set_id
    @data = BalanceBankHistory.find(params[:id])
  end
end

