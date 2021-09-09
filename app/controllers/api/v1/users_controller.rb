class Api::V1::UsersController < Api::V1::BaseController
  def index
    users = User.all.page(page).per(per_page)

    render json: users
  end
end
