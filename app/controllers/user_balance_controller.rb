class UserBalanceController < ApplicationController
  before_action do
    authenticate_request!
  end

  def index
    @data = UserBalance.all
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def create
    params[:user_id] = 4
    @data = UserBalance.create!(user_balance_params)
    msg = { :status => 200, :message => "Success create data!", :data => @data }
    render :json => msg
  end

  def show
    @data = UserBalance.find(params[:id])
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def update
    @data = UserBalance.find(params[:id])
    @data.update(user_balance_params)

    msg = { :status => 200, :message => "Successfully updated!", :data => @data }
    render :json => msg
  end

  def destroy
    @data = UserBalance.find(params[:id])
    @data.destroy

    msg = { :status => 200, :message => "Successfully delete!" }
    render :json => msg
  end

  def transfer
    # source balance
    user_balance = UserBalance.find_by(user_id: @user_id)

    check_benefit_user_exist = User.find(params[:benefit_user_id])
    if check_benefit_user_exist.blank?
      msg = { :status => 200, :message => "Destination User is not exist!"}
      return render :json => msg
    end

    benefit_trx = Transaction.new
    benefit_trx.user_id = params[:benefit_user_id]
    benefit_trx.amount  = params[:amount]
    benefit_trx.status  = "process"
    benefit_trx.request_date  = Time.now.in_time_zone('Asia/Jakarta').to_date
    benefit_trx.save

    trx_from = Transaction.new
    trx_from.user_id = @user_id
    trx_from.amount  = params[:amount]
    trx_from.status  = "process"
    trx_from.request_date  = Time.now.in_time_zone('Asia/Jakarta').to_date
    trx_from.save

    if user_balance.blank?
      msg = { :status => 200, :message => "User doesnt have balance!"}
      return render :json => msg
    else
      if user_balance.balance.to_i < params[:amount].to_i
        msg = { :status => 200, :message => "User doesnt have enough balance for transfer balance!"}
        return render :json => msg
      end

      @old_user_balance = user_balance.balance
      @total = user_balance.balance - trx_from.amount
      user_balance.balance = @total
      user_balance.save
    end


    user_balance_history = UserBalanceHistory.new
    user_balance_history.user_balance_id = user_balance.id
    user_balance_history.balance_before = @old_user_balance
    user_balance_history.balance_after = user_balance.balance
    user_balance_history.activity = "transfer"
    user_balance_history.type = params[:payment_type]
    user_balance_history.location = params[:location]
    user_balance_history.author = "user"
    user_balance_history.save

    balance_bank = BalanceBank.find_by(user_id: @user_id)
    if balance_bank.blank?
      balance_bank = BalanceBank.new
      balance_bank.user_id = @user_id
      balance_bank.balance = user_balance.balance
      balance_bank.code    = params[:bank_code]
      balance_bank.enable  = "true"
      balance_bank.save
    else
      balance_bank.balance =user_balance.balance
      balance_bank.code = params[:bank_code]
      balance_bank.enable = "true"
      balance_bank.save
    end


    balance_bank_history = BalanceBankHistory.new
    balance_bank_history.balance_bank_id = balance_bank.id
    balance_bank_history.balance_before = user_balance_history.balance_before
    balance_bank_history.balance_after  = balance_bank.balance
    balance_bank_history.activity       = user_balance_history.activity
    balance_bank_history.type           = user_balance_history.type
    balance_bank_history.ip             = user_balance_history.ip
    balance_bank_history.location       = user_balance_history.location
    balance_bank_history.author         = user_balance_history.author
    balance_bank_history.save

    ###

    ### Benefit user
    # benefit balance
    benefit_user_balance = UserBalance.find_by(user_id: params[:benefit_user_id])

    if benefit_user_balance.blank?
      @old_benefit_user_balance = 0
      benefit_user_balance = UserBalance.new
      benefit_user_balance.user_id = params[:benefit_user_id]
      benefit_user_balance.balance =  benefit_trx.amount
      benefit_user_balance.save
    else
      @old_benefit_user_balance = benefit_user_balance.balance
      @total = benefit_user_balance.balance + benefit_trx.amount
      benefit_user_balance.balance = @total
      benefit_user_balance.save
    end


    benefit_user_balance_history = UserBalanceHistory.new
    benefit_user_balance_history.user_balance_id = benefit_user_balance.id
    benefit_user_balance_history.balance_before = @old_user_balance
    benefit_user_balance_history.balance_after = benefit_user_balance.balance
    benefit_user_balance_history.activity = "topup"
    benefit_user_balance_history.type = params[:payment_type]
    benefit_user_balance_history.location = params[:location]
    benefit_user_balance_history.author = "admin"
    benefit_user_balance_history.save

    benefit_balance_bank = BalanceBank.find_by(user_id: params[:benefit_user_id])
    if benefit_balance_bank.blank?
      benefit_balance_bank = BalanceBank.new
      benefit_balance_bank.user_id = params[:benefit_user_id]
      benefit_balance_bank.balance = benefit_user_balance.balance
      benefit_balance_bank.code    = params[:bank_code]
      benefit_balance_bank.enable  = "true"
      benefit_balance_bank.save
    else
      benefit_balance_bank.balance =benefit_user_balance.balance
      benefit_balance_bank.code = params[:bank_code]
      benefit_balance_bank.enable = "true"
      benefit_balance_bank.save
    end

    benefit_balance_bank_history = BalanceBankHistory.new
    benefit_balance_bank_history.balance_bank_id = benefit_balance_bank.id
    benefit_balance_bank_history.balance_before = benefit_user_balance_history.balance_before
    benefit_balance_bank_history.balance_after  = benefit_balance_bank.balance
    benefit_balance_bank_history.activity       = benefit_user_balance_history.activity
    benefit_balance_bank_history.type           = benefit_user_balance_history.type
    benefit_balance_bank_history.ip             = benefit_user_balance_history.ip
    benefit_balance_bank_history.location       = benefit_user_balance_history.location
    benefit_balance_bank_history.author         = benefit_user_balance_history.author
    benefit_balance_bank_history.save

    benefit_trx_update = Transaction.find(benefit_trx.id)
    benefit_trx_update.status  = "success"
    benefit_trx_update.purchased_date  = Time.now.in_time_zone('Asia/Jakarta').to_date
    benefit_trx_update.save
    ###

    trx_from_update = Transaction.find(trx_from.id)
    trx_from_update.status  = "success"
    trx_from_update.purchased_date  = Time.now.in_time_zone('Asia/Jakarta').to_date
    trx_from_update.save

    @data_benefit_balance_update = benefit_user_balance
    @data_balance_from_update = user_balance

    msg = { :status => 200, :message => "Successfully transfer balance!", :data => @data_balance_from_update, :data_user_benefit => @data_benefit_balance_update}
    render :json => msg
  end

  private

  def user_balance_params
  end
end

