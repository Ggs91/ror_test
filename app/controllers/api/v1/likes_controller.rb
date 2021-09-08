class Api::V1::LikesController < Api::V1::BaseController

  def create
    like = @likeable.likes.create!(user: current_user)

    render json: like, serializer: Api::V1::StatusCreatedSerializer, status: :created
  end
end
