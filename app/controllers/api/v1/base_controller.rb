class Api::V1::BaseController < ApplicationController
  before_action :set_default_format
  before_action :set_serializer_namespace
  # before_action do
  #   self.namespace_for_serializer = Api::V1
  # end

  private

  def set_default_format
    request.format = :json
  end

  def set_serializer_namespace
    self.namespace_for_serializer = Api::V1
  end
end
