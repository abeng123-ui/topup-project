Rails.application.routes.draw do
  #post 'user_token' => 'user_token#create'
  #post 'users/create' => 'users#create'
  get '/healthz', to: 'healthz#index'

  # get "user"      => "user#index"
  post "user"     => "user#create"
  post "confirm"     => "user#confirm"
  post "login"     => "user#login"

  # get "user/:id"  => "user#show"
  # put "user/:id"  => "user#update"

  get "user-balance"               => "user_balance#index"
  post "user-balance"              => "user_balance#create"
  get "user-balance/:id"           => "user_balance#show"
  put "user-balance/:id"           => "user_balance#update"
  patch "user-balance/transfer/:id"  => "user_balance#transfer"

  get "user-balance-history"      => "user_balance_history#index"
  post "user-balance-history"     => "user_balance_history#create"
  get "user-balance-history/:id"  => "user_balance_history#show"
  put "user-balance-history/:id"  => "user_balance_history#update"

  get "balance-bank"      => "balance_bank#index"
  post "balance-bank"     => "balance_bank#create"
  get "balance-bank/:id"  => "balance_bank#show"
  put "balance-bank/:id"  => "balance_bank#update"

  get "balance-bank-history"      => "balance_bank_history#index"
  post "balance-bank-history"     => "balance_bank_history#create"
  get "balance-bank-history/:id"  => "balance_bank_history#show"
  put "balance-bank-history/:id"  => "balance_bank_history#update"

  get "transaction"      => "transaction#index"
  post "transaction"     => "transaction#create"
  get "transaction/:id"  => "transaction#show"
  put "transaction/:id"  => "transaction#update"

end
