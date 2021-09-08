module Error
  module ExceptionsHandler
    def self.included(base)
      base.class_eval do
        rescue_from ActiveRecord::RecordNotFound do |exception|
          render_error(exception, 1, :not_found)
        end
        rescue_from ActiveRecord::RecordInvalid do |exception|
          render_error(exception, 2, :unprocessable_entity)
        end
        rescue_from ActionController::ParameterMissing do |exception|
          render_error(exception, 3, :bad_request)
        end
      end
    end

    private

    def render_error(exception, code, status)
      json = JsonApiErrorSerializer.new(exception, code, status).to_json
      render json: json, status: status
    end
  end
end
