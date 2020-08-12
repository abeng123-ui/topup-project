class BalanceBankController < ApplicationController
  before_action :set_id, only: [:show, :update, :destroy]

  def index
    @data = BalanceBank.all
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def create
    @data = BalanceBank.create!(set_params)
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
    params.permit(:balance, :balance_achieve, :code, :enable)
  end

  def set_id
    @data = BalanceBank.find(params[:id])
  end
end

