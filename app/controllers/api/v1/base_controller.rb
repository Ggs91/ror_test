class Api::V1::BaseController < ApplicationController
  before_action :set_default_format
  before_action :set_serializer_namespace

  # To simplify the test, I'm using the first user in database
  def current_user
    User.first
  end

  private

  def set_default_format
    request.format = :json
  end

  def set_serializer_namespace
    self.namespace_for_serializer = Api::V1
  end
end
