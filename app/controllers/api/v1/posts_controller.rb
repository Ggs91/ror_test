class Api::V1::PostsController < Api::V1::BaseController
  def index
    posts = Post.all
    render json: posts, each_serializer: Api::PostSerializer
  end
end
