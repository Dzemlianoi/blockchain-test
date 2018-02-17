class ApplicationController < ActionController::Base
  protect_from_forgery unless: -> { request.format.json? }
  respond_to :json

  private

  def failure_response(options)
    render json: { status: :unprocessable_entity, success: false, message: error_message(options[:entity]) }
  end

  def success_response(options)
    status = options[:status] || :ok
    message = options[:message] || 'Everything ok'
    render json: { status: status, success: true, message: message }
  end


  def error_message(resource)
    return 'Something went wrong' unless resource.present?
    resource.errors.full_messages
  end
end
