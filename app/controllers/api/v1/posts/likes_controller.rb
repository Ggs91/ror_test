class Api::V1::Posts::LikesController < Api::V1::LikesController
  before_action :set_likeable

  private

  def set_likeable
    @likeable = Post.find(params[:post_id])
  end
end
