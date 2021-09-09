class Api::V1::PostsController < Api::V1::BaseController
  def index
    posts = Post.all.page(page).per(per_page)

    render json: posts
  end
end
