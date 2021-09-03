class Api::V1::UsersController < ActionController::API
  def index
    users = User.all
    render json: users, each_serializer: Api::UserSerializer
  end
end
