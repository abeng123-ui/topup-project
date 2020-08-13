class BalanceBankController < ApplicationController
  before_action do
    authenticate_request!
    check_is_admin
  end

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
    @data = BalanceBank.find(params[:id])
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def update
    @data = BalanceBank.find(params[:id])
    @data.update(set_params)

    msg = { :status => 200, :message => "Successfully updated!", :data => @data }
    render :json => msg
  end

  def destroy
    @data = BalanceBank.find(params[:id])
    @data.destroy

    msg = { :status => 200, :message => "Successfully delete!" }
    render :json => msg
  end

  private

  def set_params
    params.permit(:balance, :balance_achieve, :code, :enable)
  end

end

