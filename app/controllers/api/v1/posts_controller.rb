class Api::V1::PostsController < ActionController::API
  def index
    posts = Post.all
    render json: posts, each_serializer: Api::PostSerializer
  end
end
