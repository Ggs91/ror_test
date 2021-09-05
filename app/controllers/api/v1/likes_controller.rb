class Api::V1::LikesController < Api::V1::BaseController

  def create
    like = @likeable.likes.new(user: current_user)

    if like.save
      render json: like
    else
      render json: like, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end
end
