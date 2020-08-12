class ApplicationController < ActionController::API
  # def authorize
  #   raise NoMethodError.new('declare authorize in your controller class')
  # end

  # protected

  # def user
  #   raise HrisEmployeeService::MissingTokenError.new unless request.env['HTTP_AUTHORIZATION'].present?
  #   decoded_token = decode_token
  #   User::Create.(params: decoded_token[:user])[:model]
  # rescue NoMethodError
  #   raise HrisEmployeeService::MalformedTokenError.new
  # end

  # def decode_token
  #   token = request.env['HTTP_AUTHORIZATION']
  #   token.gsub!('Bearer ', '') if token.include? 'Bearer '
  #   JWT.decode(token, ENV['JWT_SECRET_KEY'], true, { algorithm: 'HS256' }).first.deep_symbolize_keys! rescue nil
  # end

  # def user_authorize
  #   raise MalformedTokenError.new unless user
  # end
end
