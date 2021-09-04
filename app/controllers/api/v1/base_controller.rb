class Api::V1::BaseController < ApplicationController
  before_action :set_default_format
  before_action :require_current_user

  def render_not_found
    render_errors([{ code: '2', message: 'Resource not found' }], :not_found)
  end

  private

  def require_current_user
    if current_user
      return
    end

    render_errors([{ code: '1', message: 'you must be logged in' }], :unauthorized)
  end

  def set_default_format
    request.format = :json
  end

  def render_errors(errors=[], status=:ok)
    render json: { status: :error, errors: errors }, status: status
  end
end
