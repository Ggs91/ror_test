class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_post, only: [:create]

  def create
    comment = @post.comments.new(comment_params.merge(user: current_user))

    if comment.save
      render json: { status: :success, message: 'Comment created', data: comment }, status: :ok
    else
      render_errors([{ message: 'Comment not created', data: comment.errors }], :unprocessable_entity)
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
