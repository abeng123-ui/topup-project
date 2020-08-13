class TransactionController < ApplicationController
  before_action do
    authenticate_request!
  end

  def index
    @data = Transaction.all
    msg = { :status => 200, :message => "Success!", :data => @data }
    render :json => msg
  end

  def create
    @data = Transaction.new
    @data.user_id = @user_id
    @data.amount = params[:amount]
    @data.status = "process"
    @data.request_date = Time.now.in_time_zone('Asia/Jakarta').to_date
    @data.save

    msg = { :status => 200, :message => "Success create topup request!", :data => @data }
    render :json => msg
  end

  def show
    @data = Transaction.find(params[:id])
    msg = { :status => 200, :message => "Success!", :data => @data }
    return render :json => msg
  end

  def update
    checkUserIsAdmin = User.find(@user_id);
    if checkUserIsAdmin.role != 'admin'
      msg = { :status => 200, :message => "You are not have priveleges!"}
      return render :json => msg
    end

    trx = Transaction.find(params[:id])
    if trx.blank?
      msg = { :status => 200, :message => "Transaction is not found!"}
      return render :json => msg
    end

    trx.status = 'success'
    trx.purchased_date = Time.now.in_time_zone('Asia/Jakarta').to_date
    trx.save

    user_balance = UserBalance.find_by(user_id: trx.user_id)

    if user_balance.blank?
      @old_user_balance = 0
      user_balance = UserBalance.new
      user_balance.user_id = trx.user_id
      user_balance.balance =  trx.amount
      user_balance.save
    else
      @old_user_balance = user_balance.balance
      @total = user_balance.balance + trx.amount
      user_balance.balance = @total
      user_balance.save
    end


    user_balance_history = UserBalanceHistory.new
    user_balance_history.user_balance_id = user_balance.id
    user_balance_history.balance_before = @old_user_balance
    user_balance_history.balance_after = user_balance.balance
    user_balance_history.activity = "topup"
    user_balance_history.type = params[:payment_type]
    user_balance_history.location = params[:location]
    user_balance_history.author = "admin"
    user_balance_history.save

    balance_bank = BalanceBank.find_by(user_id: trx.user_id)
    if balance_bank.blank?
      balance_bank = BalanceBank.new
      balance_bank.user_id = params[:user_id]
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

    @data = trx

    msg = { :status => 200, :message => "Successfully approve topup!", :data => @data }
    render :json => msg
  end

  def destroy
    @data = Transaction.find(params[:id])
    @data.destroy

    msg = { :status => 200, :message => "Successfully delete!" }
    render :json => msg
  end

  private

  def set_params
    params.permit(:amount, :payment_type, :ip, :location, :bank_code)
  end

end

