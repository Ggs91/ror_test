class Api::V1::Comments::LikesController < Api::V1::LikesController
  before_action :set_likeable

  private

  def set_likeable
    @likeable = Comment.find_by(post: params[:post_id], id: params[:comment_id])
  end
end
