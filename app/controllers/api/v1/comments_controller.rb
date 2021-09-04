class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_post, only: [:index, :create]

  def index
    comments = @post.comments.page(page).per(per_page)

    render json: comments, each_serializer: Api::CommentSerializer
  end

  def create
    comment = @post.comments.new(comment_params.merge(user: current_user))

    if comment.save
      render json: comment, serializer: Api::CommentSerializer
    else
      render json: comment, status: 422, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
