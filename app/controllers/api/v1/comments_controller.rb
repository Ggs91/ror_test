class Api::V1::CommentsController < Api::V1::BaseController
  before_action :set_post, only: [:index, :create]

  def index
    comments = @post.comments.includes(:user, :likes).page(page).per(per_page)

    render json: comments, include: ['user', 'post']
  end

  def create
    comment = @post.comments.create!(comment_params.merge(user: current_user))

    render json: comment, include: ['user', 'post']
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
