class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity_response

  def unprocessable_entity_response(exception)
    render json: { errors: exception.record.errors.full_messages }, status: :unprocessable_entity
  end

  def not_found_response(exception)
    render json: { error: "#{exception.message} not found" }, status: :not_found
  end
end