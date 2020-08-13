class ApplicationController < ActionController::API
  require 'json_web_token'

  protected
  # Validates the token and user and sets the @current_user scope
  def authenticate_request!
    if !payload || !JsonWebToken.valid_payload(payload.first)
      return invalid_authentication
    end

    load_current_user!
    invalid_authentication unless @current_user
  end

  # Returns 401 response. To handle malformed / invalid requests.
  def invalid_authentication
    render json: {error: 'Invalid Request'}, status: :unauthorized
  end

  private
  # Deconstructs the Authorization header and decodes the JWT token.
  def payload
    auth_header = request.headers['Authorization']
    token = auth_header.split(' ').last
    JsonWebToken.decode(token)
  rescue
    nil
  end

  # Sets the @current_user with the user_id from payload
  def load_current_user!
    puts "PAYLOAAAD #{payload}"
    @current_user = User.find(payload[0]['user_id'])
    @user_id = payload[0]['user_id']

  end

  def check_is_admin
    checkUserIsAdmin = User.find(@user_id);
    if checkUserIsAdmin.role != 'admin'
      msg = { :status => 401, :message => "You are not have priveleges!"}
      return render :json => msg
    end
  end
end
