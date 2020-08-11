module Api::V1
  class HomeController < ApplicationController

    before_action :authenticate_user, only: [:auth]

    def index
      render json: { service: 'auth-api', status: 200 }
    end

    def auth
      @role = current_user.role rescue nil
      render json: { status: 200, msg: 'You are currently Logged in as #{current_user.first_name}', role: @role }
    end

    def generate_generic_response(result)
      if result.success?
        @data = result[:result] if @data.blank?
      else
        @error  = true
        @data   = result['result.contract.default'].errors.messages rescue nil
        @status = 'fail'
        @message = 'validation error'
      end
    end

  end

end
